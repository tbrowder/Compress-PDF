unit module Compress;

use Compress::PDF;

multi sub run-compress(@args} is export {
    my $ifil;
    my $ofil;
    my $dpi = 150; # default
    for @args {
        when not $ifil.defined {
            if $_.IO.r {
                $ifil = $_;
            }
        }
        when /^:i d[p|pi]? '=' (\d\d\d) / {
            $dpi = ~$0;
            unless $dpi eq '150' or $dpi eq '300' {
                say "FATAL: dpi values must be 150 or 300, you entered '$dpi'";
                exit;
            }
        }
        default {
            say "FATAL: Unknown arg '$_'"; exit;
        }
    }

    # ps2pdf -dPDFSETTINGS=/ebook jsakahara.pdf jsakahara-150dpi.pdf
    # ps2pdf -dPDFSETTINGS=/printer jsakahara.pdf jsakahara-300dpi.pdf
}

multi sub run-compress(} is export {
    # show the no-args help stuff
    print qq:to/HERE/;
    Usage: {$*PROGRAM.basename} <pdf file> [..options...]

    Without options, compresses the input PDF file to the
      default 150 dpi.

    The input file is not modified, and the output file is
      named as the input file with the extension '.pdf'
      replaced by '-nnndpi.pdf' where 'nnn' is the selected
      value of '150' (the default' or '300'.

    Options:
        dpi=X - where X is the PDF compression level: '150' or '300' DPI.

    HERE
    exit
}
