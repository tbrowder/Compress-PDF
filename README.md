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

    $ compress-pdf calendar.pdf
    # OUTPUT
    Input file: calendar.pdf
      Size: 2.9M
    Compressed output file: calendar-150dpi.pdf
      Size: 247.7K

DESCRIPTION
===========

**Compress::PDF** requires a system utitlity program: 'ps2pdf'. On Debian systems it can be installed by executing `sudo aptitude install ps2pdf`.

Installing this module results in one primary and two aliased Raku PDF compression programs:

  * compress-pdf

  * pdf-compress #= aliased to `compress-pdf`

Executing either name without input arguments results in:

    Usage: compress-pdf <pdf file> [..options...]

    Without options, compresses the input PDF file to the
      default 150 dpi.

    The input file is not modified, and the output file is
      named as the input file with the extension '.pdf'
      replaced by '-NNNdpi.pdf' where 'NNN' is the selected
      value of '150' (the default) or '300'.

    Options:
        dpi=X - where X is the PDF compression level: '150' or '300' DPI.

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2024 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

