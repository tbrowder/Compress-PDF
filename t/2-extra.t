use Test;
use Compress::PDF;
use File::Copy;

# Required to use without mi6:
%*ENV<RAKUDOLIB> = "lib";
my @f = <
    calendar.pdf
    calendar-150dpi.pdf
    calendar-300dpi.pdf
    FAKE.pdf
    calendar
    calendar.txt
    t/data/FAKE.pdf
    t/data/calendar
    t/data/calendar.txt
>;
END { unlink $_ if $_.IO.e for @f; }

my $debug = 0;

# Prepare three more temporary input files
my $f  = "t/data/calendar.pdf";
my $f0 = "t/data/calendar";
my $fx = "t/data/calendar.txt";
my $fX = "t/data/FAKE.pdf";

cp $f, $f0;
cp $f, $fx;
cp "t/2-extra.t", $fX;

my ($proc, $out, $err);


my $test = 0;

plan 6;

#===================================
=begin comment
Test 1
out: Input file: t/data/calendar.txt   Size: 2.9M Compressed output file: calendar.txt   Size: 247.7K
err: 
=end comment
++$test; say "Test $test" if $debug;
$proc = run "bin/compress-pdf", "t/data/calendar.txt", :out, :err;
$out = $proc.out.slurp(:close).lines.join(" ");
$err = $proc.err.slurp(:close).lines.join(" ");
if $debug {
    say "out: ", $out;
    say "err: ", $err;
}
else {
    like $out, /:i output \h* file/;
    like $err, /:i \h*  /;
}

#===================================
=begin comment
Test 2
out: Input file: t/data/calendar.pdf   Size: 2.9M Compressed output file: calendar-150dpi.pdf   Size: 247.7K
err: 
=end comment
++$test; say "Test $test" if $debug;
$proc = run "bin/compress-pdf", "dpi=150", "t/data/calendar", :out, :err;
$out = $proc.out.slurp(:close).lines.join(" ");
$err = $proc.err.slurp(:close).lines.join(" ");
if $debug {
    say "out: ", $out;
    say "err: ", $err;
}
else {
    like $out, /:i output \h* file/;
    like $err, /:i \h*  /;
}

=begin comment
Test 3
out: 
err: FATAL: Input file 't/data/FAKE.pdf' is NOT a PDF file.   in sub run-compress at /usr/local/git-repos/my-public-modules/Compress-PDF/lib/Compress/PDF.rakumod (Compress::PDF) line 34   in block <unit> at bin/compress-pdf line 6 
=end comment
++$test; say "Test $test" if $debug;

#dies-ok {
$proc = run "bin/compress-pdf", "dpi=150", "t/data/FAKE.pdf", :out, :err;
$out = $proc.out.slurp(:close).lines.join(" ");
$err = $proc.err.slurp(:close).lines.join(" ");
if $debug {
    say "out: ", $out;
    say "err: ", $err;
}
else {
    like $out, /:i \h* /;
    like $err, /:i fatal  /;
}
#}
