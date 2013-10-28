use strict;
use Test::More;
use HTTP::Request::Common;
use HTTP::Response;
use Shodo;
use JSON qw/to_json/;

my $shodo = Shodo->new;
my $suzuri = $shodo->new_suzuri;

my $data = { method => 'echo', param => { message => 'Hello' } };
my $req = POST '/endpoint';
$req->content(to_json($data));
$req->header('Content-Type' => 'application/json');
$suzuri->request($req);

my $res = HTTP::Response->new(200);
$res->content(to_json( { result => { message => "hello" } }));
$res->header('Content-Type' => 'application/json');
$suzuri->response($res);

ok $suzuri->doc();

done_testing;
