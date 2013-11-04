use strict;
use Test::More;
use HTTP::Request;
use HTTP::Response;
use JSON qw/to_json/;
use Shodo::Test::JSONRPC;

shodo_document_root('sample_documents');

shodo_test 'get_entries' => sub {
    shodo_params(
        category => { isa => 'Str', documentation => 'Category of articles.' },
        limit => { isa => 'Int', default => 20, optional => 1, documentation => 'Limitation numbers per page.' },
        page => { isa => 'Int', default => 1, optional => 1, documentation => 'Page number you want to get.' }
    );
    my $data = {
        jsonrpc => '2.0',
        method  => 'get_entries',
        params  => { limit => 1, category => 'technology' }
    };
    my $json = to_json($data);
    my $req = HTTP::Request->new(
        'POST',
        '/',
        [ 'Content-Type' => 'application/json', 'Content-Length' => length $json ],
        $json
    );
    shodo_req_ok($req, 'Request is valid!');
    my $res = HTTP::Response->new(200);
    $data = {
        jsonrpc => '2.0',
        result => {
            entries => [ { title => 'Hello', body => 'This is an example.' } ]
        },
        id => 1
    };
    $json = to_json($data);
    $res->content($json);
    $res->header('Content-Type' => 'application/json');
    shodo_res_ok($res, 200, 'Response is ok!'); # auto sock document
};

ok(shodo_doc());

done_testing();
