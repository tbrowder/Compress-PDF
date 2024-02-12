unit module Compress::PDF;

multi sub run-compress(@args) is export {
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
    
    # we should have all input to proceed
    unless $ifil.defined {
        say "FATAL: No input file was entered. Exiting.";
        exit;
    }

    $ofil = $ifil;
    $ofil = $ifil.IO.basename;
    if $ofil !~~ /:i '.pdf'$/ {
        $ofil ~= '.pdf';
        # eliminate double dots
        $ofil ~~ s:g/'..'/./;
    }
    else {
        # lower-case the .pdf
        $ofil ~~ s/:i pdf$/pdf/;
    }

    # insert the correct dpi info
    $ofil ~~ s/'.pdf'$/-{$dpi}dpi.pdf/;
    my $arg;
    if $dpi eq "150" {
        $arg = "-dPDFSETTINGS=/ebook";
    }
    elsif $dpi eq "300" {
        $arg = "-dPDFSETTINGS=/printer";
    }
    run "ps2pdf", $arg, $ifil, $ofil;
    my $isiz  = $ifil.IO.s;
    my $osiz = $ofil.IO.s;

    print qq:to/HERE/;
    Input file: $ifil
      Size: $isiz
    Compressed output file: $ofil
      Size: $osiz
    HERE
    exit	

}

multi sub run-compress() is export {
    # show the no-args help stuff
    print qq:to/HERE/;
    Usage: {$*PROGRAM.basename} <pdf file> [..options...]

    Without options, compresses the input PDF file to the
      default 150 dpi.

    The input file is not modified, and the output file is
      named as the input file with the extension '.pdf'
      replaced by '-NNNdpi.pdf' where 'NNN' is the selected
      value of '150' (the default) or '300'.

    Options:
        dpi=X - where X is the PDF compression level: '150' or '300' DPI.

    HERE
    exit
}
