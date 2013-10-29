# NAME

Shodo - Auto-generate documents from HTTP::Request and HTTP::Response

# SYNOPSIS

    use HTTP::Request::Common;
    use HTTP::Response;
    use Shodo;

    my $shodo = Shodo->new();
    my $suzuri = $shodo->new_suzuri('An endpoint method.');

    my $req = POST '/entry', [ id => 1, message => 'Hello Shodo' ];
    $suzuri->request($req);
    my $res = HTTP::Response->new(200);
    $res->content('{ "message" : "success" }');
    $suzuri->response($res);

    print $suzuri->document(); # print document as Markdown format

# DESCRIPTION

Shodo is ...

# LICENSE

Copyright (C) Yusuke Wada.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Yusuke Wada <yusuke@kamawada.com>
