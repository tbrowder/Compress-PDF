unit module Compress::PDF;

multi sub run-cli(@args) is export {

    my $dpi = 150;
    my $ifil;
    for @args {
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

    # report final results
    if $outfile !~~ /:i '.pdf'$/ {
        $outfile ~= '.pdf';
        # eliminate double dots
        $outfile ~~ s:g/'..'/./;
    }
    else {
        # lower-case the .pdf
        $outfile ~~ s/:i pdf$/pdf/;
    }

        # insert the correct zip info
        $outfile ~~ s/'.pdf'$/.{$Zip}dpi.pdf/;
        my $tmpfil = "/tmp/pdfout.pdf";
        $pdf.save-as: $tmpfil;
        my $arg;
        if $Zip eq "150" {
            $arg = "-dPDFSETTINGS=/ebook";
        }
        elsif $Zip eq "300" {
            $arg = "-dPDFSETTINGS=/printer";
        }
        run "ps2pdf", $arg, $tmpfil, $outfile;
    }
    else {
        $pdf.save-as: $outfile;
    }
    say "See combined pdf: {$outfile}";
    say "Total pages: $new-pages";

} #multi sub run-cli(@args) is export {
#==== end of this file's content ============
