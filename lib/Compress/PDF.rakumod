unit module Compress::PDF;

multi sub run-compress(@args) is export {
    my $ifil;
    my $ofil;
    my $dpi = 150; # default
    for @args {
        when /:i dpi '=' (\d\d\d) / {
            $dpi = ~$0;
            unless $dpi eq '150' or $dpi eq '300' {
                die "FATAL: dpi values must be 150 or 300, you entered '$dpi'";
            }
        }
        when not $ifil.defined {
            if $_.IO.r {
                $ifil = $_;
            }
        }
        default {
            die "FATAL: Unknown arg '$_'";
        }
    }
    
    # we should have all input to proceed
    unless $ifil.defined {
        die "FATAL: No input file was entered. Exiting.";
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
    my $proc = run "ps2pdf", $arg, $ifil, $ofil, :out, :err;
    my $out  = $proc.out.slurp(:close).words.join(" ");
    my $err  = $proc.err.slurp(:close).words.join(" ");


    my $isiz = $ifil.IO.s;
    $isiz = pretty-print $isiz;

    my $osiz = $ofil.IO.s;
    $osiz = pretty-print $osiz;

    print qq:to/HERE/;
    Input file: $ifil
      Size: $isiz
    Compressed output file: $ofil
      Size: $osiz
    HERE
    exit	

}

sub pretty-print($s) {
    # given an input file size in bits, print its size
    # to one decimal place as n.nK or n.nM
    my $kb = 1024.0;
    my $mb = 1000.0 * $kb;
    my $gb = 1000.0 * $mb;
    my $tb = 1000.0 * $gb;
    my $eb = 1000.0 * $tb;
     
    my $res;
    with $s {
        when $_ < $mb {
            $res = $s / $kb;
            $res = sprintf '%.1fK', $res;
        }
        when $_ < $gb {
            $res = $s / $mb;
            $res = sprintf '%.1fM', $res;
        }
        when $_ < $tb {
            $res = $s / $gb;
            $res = sprintf '%.1fG', $res;
        }
        when $_ < $eb {
            $res = $s / $tb;
            $res = sprintf '%.1fT', $res;
        }
        default {
            die "FATAL: Unable to handle file size of $s bits (> Exabyte)";
        }
    }
    $res
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
