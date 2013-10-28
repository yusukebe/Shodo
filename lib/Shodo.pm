package Shodo;
use 5.008005;
use strict;
use warnings;
use Shodo::Suzuri;
use Shodo::Hanshi;
use Path::Tiny qw/path/;

our $VERSION = "0.01";

sub new {
    my ($class, %args) = @_;
    my $self = bless {
        template => $args{template},
        document_root => $args{document_root} || path('./doc')
    }, $class;
    $self;
}

sub template {
    my ($self, $tmpl) = @_;
    return $self->{template} unless $tmpl;
    $self->{template} = $tmpl;
    return $self->{template};
}

sub document_root {
    my ($self, $path) = @_;
    return $self->{document_root} unless $path;
    $self->{document_root} = path($path);
    return $self->{document_root};
}

sub new_suzuri {
    my ($self, $description) = @_;
    my $hanshi = Shodo::Hanshi->new(
        template => $self->template,
    );
    return Shodo::Suzuri->new(
        hanshi => $hanshi,
        description => $description,
        document_root => $self->document_root
    );
}

1;
__END__

=encoding utf-8

=head1 NAME

Shodo - Auto-generate documents from HTTP::Request and HTTP::Response

=head1 SYNOPSIS

    use HTTP::Request::Common;
    use HTTP::Response;
    use Shodo;
    
    my $shodo = Shodo->new();
    my $suzuri = $shodo->new_suzuri('An endpoint method.');

    my $req = POST '/entry', [ id => 1, message => 'Hello Shodo' ];
    $suzuri->request($req);
    my $res = HTTP::Response->new(200);
    $res->content('{ message => "success" }');
    $suzuri->response($res);

    print $suzuri->document(); # print document as Markdown format

=head1 DESCRIPTION

Shodo is ...

=head1 LICENSE

Copyright (C) Yusuke Wada.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yusuke Wada E<lt>yusuke@kamawada.comE<gt>

=cut

