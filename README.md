[![Actions Status](https://github.com/raku-community-modules/Trait-IO/actions/workflows/test.yml/badge.svg)](https://github.com/raku-community-modules/Trait-IO/actions)

NAME
====

Trait::IO - Helper IO traits

SYNOPSIS
========

```raku
use Trait::IO;

for <a b c> {
    my $fh does auto-close = .IO.open: :w;
    # ... do things with the file handle
    # $fh is auto-closed on block leave
}

# Top-level is OK too; will close on scope leave
my $fh does auto-close = "foo".IO.open: :w;
# ...
```

DESCRIPTION
===========

Useful traits for working with Raku IO.

EXPORTS
=======

-head2 does auto-close

```raku
my $fh does auto-close = "foo".IO.open: :w;
```

Installs a `LEAVE` phaser to automatically close the file handle when scope is left.

Exports the <auto-close> constant and the `trait_mod:<does>` multi that accepts it as a value.

Currently works only with variables and not with attributes or parameters. Patches welcome.

AUTHOR
======

Zoffix Znet

COPYRIGHT AND LICENSE
=====================

Copyright 2017 - 2018 Zoffix Znet

Copyright 2019 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

