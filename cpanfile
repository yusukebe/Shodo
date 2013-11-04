requires 'perl', '5.008001';

requires 'HTTP::Message';
requires 'JSON';
requires 'Text::MicroTemplate';
requires 'Try::Tiny';
requires 'Data::Validator';
requires 'Clone';
requires 'Path::Tiny';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

