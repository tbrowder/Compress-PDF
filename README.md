[![Actions Status](https://github.com/tbrowder/Compress-PDF/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/Compress-PDF/actions) [![Actions Status](https://github.com/tbrowder/Compress-PDF/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/Compress-PDF/actions) [![Actions Status](https://github.com/tbrowder/Compress-PDF/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/Compress-PDF/actions)

NAME
====

**Compress::PDF** - Provides PDF compression binary executables `compress-pdf` and its alias `pdf-compress`

SYNOPSIS
========

```raku
use Compress::PDF
```

In your terminal window:

    $ compress-pdf foo.pdf
    # OUTPUT
    Input file: foo.pdf
      Size: ?
    Compressed output file: foo-150dpi.pdf
      Size: ?

DESCRIPTION
===========

**Compress::PDF** requires a system utitlity program: 'ps2pdf'. On Debian systems it can be installed by executing `sudo aptitude install ps2pdf`.

Installing this module results in one primary and two aliased Raku PDF compression programs:

  * compress-pdf

  * pdf-compress #= aliased to `compress-pdf`

Executing either name without input arguments results in:

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2024 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

