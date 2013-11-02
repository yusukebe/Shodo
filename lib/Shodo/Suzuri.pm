package Shodo::Suzuri;
use strict;
use warnings;
use Carp qw//;
use Try::Tiny;
use JSON qw/from_json to_json/;
use Data::Validator;
use Clone qw/clone/;

sub new {
    my ($class, %args) = @_;
    my $self = bless {
        hanshi => $args{hanshi}
    }, $class;
    $self->stash->{description} = $args{description} || '';
    $self;
}

sub hanshi {
    shift->{hanshi};
}

sub stash {
    my $self = shift;
    $self->{stash} ||= {};
    return $self->{stash};
}

sub request {
    my ($self, $req) = @_;
    unless (try { $req->isa('HTTP::Request') }) {
        Carp::croak("Request is not HTTP::Request: $req");
    }
    $self->stash->{method} = $req->method;
    $self->stash->{path} = $req->uri->path;
    $self->stash->{query} = $req->uri->query;
    $self->stash->{request_body} = $req->content;
    if($req->content_type =~ m!^application/json!) {
        my $json_body = to_json(from_json($req->decoded_content), { pretty => 1 });
        $self->stash->{request_body} = $json_body;
    }
    return $req;
}

sub response {
    my ($self, $res) = @_;
    unless (try { $res->isa('HTTP::Response') }) {
        Carp::croak("Response is not HTTP::Response: $res");
    }
    $self->stash->{code} = $res->code;
    $self->stash->{status_line} = $res->status_line;
    $self->stash->{response_body} = $res->content;
    if($res->content_type =~ m!^application/json!) {
        my $json_body = to_json(from_json($res->decoded_content), { pretty => 1 });
        $self->stash->{response_body} = $json_body;
    }
    return $res;
}

sub document {
    my $self = shift;
    return $self->hanshi->render( $self->stash );
}

sub params {
    my ($self, %args) = @_;
    $self->stash->{rule} = clone(\%args);
    my $validator = Data::Validator->new( %args );
    $self->{validator} = $validator;
}

sub validate {
    my ($self, @args) = @_;
    Carp::croak "Rule is not set on Suzuri instance" unless $self->{validator};
    my $result;
    if( ref $args[0] && ref $args[0] eq 'HASH') {
        $result = $self->{validator}->validate($args[0]);
    }else{
        $result = $self->{validator}->validate(@args);
    }
    return $result;
}

*req = \&request;
*res = \&response;
*doc = \&document;
*rule = \&params;

1;
