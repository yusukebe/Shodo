package Shodo;
use 5.008005;
use strict;
use warnings;
use Shodo::Suzuri;
use Shodo::Hanshi;

our $VERSION = "0.01";

sub new {
    my ($class, %args) = @_;
    my $self = bless \%args, $class;
    $self;
}

sub new_suzuri {
    my $self = shift;
    my $hanshi = Shodo::Hanshi->new( template => $self->{template} );
    return Shodo::Suzuri->new( hanshi => $hanshi );
}

1;
__END__

=encoding utf-8

=head1 NAME

Shodo - It's new $module

=head1 SYNOPSIS

    use Shodo;

=head1 DESCRIPTION

Shodo is ...

=head1 LICENSE

Copyright (C) Yusuke Wada.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yusuke Wada E<lt>yusuke@kamawada.comE<gt>

=cut

