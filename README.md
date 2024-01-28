[![Actions Status](https://github.com/tbrowder/App-PDF-Compressor/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/App-PDF-Compressor/actions) [![Actions Status](https://github.com/tbrowder/App-PDF-Compressor/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/App-PDF-Compressor/actions) [![Actions Status](https://github.com/tbrowder/App-PDF-Compressor/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/App-PDF-Compressor/actions)

NAME
====

**App::PDF-Compressor** - Provides a PDF compression binary executable, 'pdf-compressor'

SYNOPSIS
========

```raku
use App::PDF-Compressor
```

In your terminal window:

    $ pdf-compressor foo.pdf
    # OUTPUT
    Input file: foo.pdf
      Size: ?
    Compressed output file: foo-150dpi.pdf
      Size: ?

DESCRIPTION
===========

**App::PDF-Compressor** requires a system utitlity program: 'ps2pdf'. On Debian systems it can be installed by executing `sudo aptitude install ps2pdf`.

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2024 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

