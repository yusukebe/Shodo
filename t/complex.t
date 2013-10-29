use strict;
use Test::More;
use HTTP::Request::Common;
use HTTP::Response;
use Shodo;
use JSON qw/to_json/;

my $shodo = Shodo->new( document_root => 'sample_documents' );
my $suzuri = $shodo->new_suzuri('JSON-RPC like method "get_entries"');

my $data = {
    method => 'get_entries',
    params => { category => 'technology', limit => 1, page => 1 }
};

$suzuri->rule(
    category => { isa => 'Str', documentation => 'Category of articles.' },
    limit => { isa => 'Int', default => 20, optional => 1, documentation => 'Limitation numbers per page.' },
    page => { isa => 'Int', default => 1, optional => 1, documentation => 'Page number you want to get.' }
);
ok $suzuri->validate($data->{params});

my $req = POST '/endpoint';
$req->content(to_json($data));
$req->header('Content-Type' => 'application/json');
$suzuri->request($req);

my $res = HTTP::Response->new(200);
$res->content(
    to_json(
        {
            result => {
                entries => [ { title => 'Hello', body => 'This is an example.' } ]
            }
        }
    )
);
$res->header('Content-Type' => 'application/json');
$suzuri->response($res);

ok $suzuri->doc();
$suzuri->write('test.md');

done_testing;
