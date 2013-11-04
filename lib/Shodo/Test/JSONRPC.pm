package Shodo::Test::JSONRPC;
use strict;
use warnings;
use Shodo;
use parent qw/Exporter/;
use JSON qw/from_json/;
use Try::Tiny;
use Test::More;

our @EXPORT = qw/
    shodo_document_root
    shodo_test
    shodo_params
    shodo_req_ok
    shodo_res_ok
    shodo_doc
    shodo_write
/;

my $shodo = Shodo->new();
my $suzuri;

sub shodo_document_root {
    my $dir = shift;
    $shodo->document_root($dir);
}

sub shodo_test {
    my ($description, $coderef) = @_;
    $suzuri = $shodo->new_suzuri($description) unless $suzuri;
    my $result = Test::More::subtest($description => $coderef);
}

sub shodo_params {
    my %args = @_;
    $suzuri->params(%args);
}

sub shodo_req_ok {
    my ($req, $note) = @_;
    $suzuri->request($req);
    my $data = try {
        from_json($req->content);
    }catch{
        warn "$_\n";
    };
    return unless $data;
    return unless $suzuri->validate($data->{params});
    Test::More::ok($req, $note);
}

sub shodo_res_ok {
    my ($res, $code, $note) = @_;
    $suzuri->response($res);
    my $result = Test::More::is $res->code, 200, $note;
    $shodo->stock($suzuri->doc());
    $suzuri = undef;
    return $result;
}

sub shodo_doc {
    return $shodo->stock();
}

sub shodo_write {
    my $filename = shift;
    $shodo->write($filename);
}

1;

__END__

=encoding utf-8

=head1 NAME

Shodo::Test::JSONRPC - 

=head1 SYNOPSIS

    use Test::More;
    use Shodo::Test::JSONRPC;

=head1 DESCRIPTION

Shodo generates Web API documents as Markdown format automatically and validates parameters using HTTP::Request/Response.

B<THIS IS A DEVELOPMENT RELEASE. API MAY CHANGE WITHOUT NOTICE>.

=head1 LICENSE

Copyright (C) Yusuke Wada.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yusuke Wada E<lt>yusuke@kamawada.comE<gt>

=cut

