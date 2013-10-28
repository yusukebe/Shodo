package Shodo::Suzuri;
use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    my $self = bless { hanshi => $args{hanshi} }, $class;
    $self;
}

sub hanshi {
    return shift->{hanshi};
}

sub stash {
    my $self = shift;
    $self->{stash} ||= {};
    return $self->{stash};
}

sub request {
    my ($self, $req) = @_;
    # TODO:Validate $req object
    $self->stash->{method} = $req->method;
    $self->stash->{path} = $req->uri->path;
    $self->stash->{query} = $req->uri->query;
    $self->stash->{request_body} = $req->content;
    # TODO:If body is a json format
    return $req;
}

sub response {
    my ($self, $res) = @_;
    # TODO:Validate $res object
    $self->stash->{code} = $res->code;
    $self->stash->{status_line} = $res->status_line;
    $self->stash->{response_body} = $res->content;
    return $res;
}

sub document {
    my $self = shift;
    return $self->hanshi->render( $self->stash );
}

*req = \&request;
*res = \&response;
*doc = \&document;

1;
