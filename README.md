[![Actions Status](https://github.com/tbrowder/Compress-PDF/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/Compress-PDF/actions) [![Actions Status](https://github.com/tbrowder/Compress-PDF/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/Compress-PDF/actions) [![Actions Status](https://github.com/tbrowder/Compress-PDF/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/Compress-PDF/actions)

NAME
====

**Compress::PDF** - Provides PDF compression binary executables `compress-pdf` (and its aliases)

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
    Compressed output file: calendar-300dpi.pdf
      Size: 247.7K

DESCRIPTION
===========

**Compress::PDF** requires a system utitlity program: 'ps2pdf'. On Debian systems it can be installed by executing `sudo aptitude install ps2pdf`.

Installing this module results in an exported subroutine as well as one primary and two aliased Raku PDF compression programs:

  * sub compress($inpdf, :$quiet, :$dpi = 300, :$outpdf, :$force) is export {...}

  * compress-pdf

  * pdf-compress #= aliased to `compress-pdf`

  * compress #= aliased to `compress-pdf`

Programs
--------

Executing either of the three program names without input arguments results in:

    Usage: compress-pdf <pdf file> [..options...]

    Without options, the program compresses the input PDF file to the
      default 300 dpi.

    The input file is not modified, and the output file is
      named as the input file with any extension or suffix
      replaced by '-NNNdpi.pdf' where 'NNN' is the selected
      value of '150' or '300' (the default).

    Options:
      dpi=X    - where X is the PDF compression level: '150' or '300' DPI.
      force    - allows overwriting an existing output file
      outpdf=X - where X is the desired output name

Note the the default output file will overwrite an existing file of the same name without warning.

Environment variable COMPRESS_PDF_COMPRESS_OFF
----------------------------------------------

On Debian systems the alias name 'compress' should cause no conflicts with another packaged binary file. However, if any user finds alias 'compress' causes problems, it can be turned off by setting environment variable `COMPRESS_PDF_COMPRESS_OFF=1`. File an issue if that doesn't work for your system.

Subroutine
----------

The subroutine has the following signature:

    sub compress($inpdf, :$quiet, :$dpi = 300,
                 :$outpdf, :$force) is export {...}

The `:$quiet` option is designed for use in programs where the user's desired output file name is designed to be quietly and seamlessly compressed by default. Other options provide more flexibilty and choices to offer the user if the `$quiet` option is **not** used.

If the `:$outpdf` is not entered, the `$outpdf` is named using the same scheme as the programs. The `:$force` option allows overwriting an existing file.

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2024-2025 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

