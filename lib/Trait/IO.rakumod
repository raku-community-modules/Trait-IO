unit module Trait::IO;

my constant auto-close is export = class {};

multi sub trait_mod:<does>(Variable:D $v, auto-close) is export {
    use nqp;
    $v.block.add_phaser: 'LEAVE', $v.willdo: {
        my $ctx := nqp::ctxcaller(  # at least this many frames up
          nqp::ctxcaller(
            nqp::ctxcaller(
              nqp::ctxcaller(
                nqp::ctx()
              )
            )
          )
        );
        my str $name = $v.name;;
        nqp::until(                  # assume first found is ok
          (my $code := try nqp::atkey($ctx,$name)),
          $ctx := nqp::ctxcaller($ctx)
        );
        $code.close if $code;        # .close if found
    }
}

=begin pod

=head1 NAME

Trait::IO - Helper IO traits

=head1 SYNOPSIS

=begin code :lang<raku>

use Trait::IO;

for <a b c> {
    my $fh does auto-close = .IO.open: :w;
    # ... do things with the file handle
    # $fh is auto-closed on block leave
}

# Top-level is OK too; will close on scope leave
my $fh does auto-close = "foo".IO.open: :w;
# ...

=end code

=head1 DESCRIPTION

Useful traits for working with Raku IO.

=head1 EXPORTS

-head2 does auto-close

=begin code :lang<raku>

my $fh does auto-close = "foo".IO.open: :w;

=end code

Installs a C<LEAVE> phaser to automatically close the file handle when scope
is left.

Exports the <auto-close> constant and the C<trait_mod:<does>> multi that
accepts it as a value.

Currently works only with variables and not with attributes or parameters.
Patches welcome.

=head1 AUTHOR

Zoffix Znet

=head1 COPYRIGHT AND LICENSE

Copyright 2017 - 2018 Zoffix Znet

Copyright 2019 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
