use Test;
use Compress::PDF;
use File::Copy;

my $debug = 0;

# Required to use without mi6:
%*ENV<RAKUDOLIB> = "lib";
my @f = <
    calendar.pdf
    calendar-150dpi.pdf
    calendar-300dpi.pdf
    FAKE.pdf
    calendar
    calendar.txt
    t/data/calendar
    t/data/calendar.txt
>;

# Prepare three more temporary input files
my $f  = "t/data/calendar.pdf";
my $f0 = "t/data/calendar";
my $fx = "t/data/calendar.txt";
my $fX = "t/data/FAKE.pdf";

cp $f, $f0;
cp $f, $fx;

my ($proc, $out, $err);

my $test = 0;

plan 6;

#===================================
# Test 1
# out: Input file: t/data/calendar.txt
# err: 
#===================================
++$test; say "Test $test" if $debug;
$proc = run "bin/compress-pdf", "t/data/calendar.txt", :out, :err;
$out = $proc.out.slurp(:close).lines.head // "";
$err = $proc.err.slurp(:close).lines.head // "";
if $debug {
    say "out: '$out'";
    say "err: '$err'";
}
else {
    like $out, /:i input \h* file/;
    like $err, /:i \h*  /;
}

#===================================
# Test 2
# out: Input file: t/data/calendar
# err: 
#===================================
++$test; say "Test $test" if $debug;
$proc = run "bin/compress-pdf", "dpi=150", "t/data/calendar", :out, :err;
$out = $proc.out.slurp(:close).lines.head // "";
$err = $proc.err.slurp(:close).lines.head // "";
if $debug {
    say "out: '$out'";
    say "err: '$err'";
}
else {
    like $out, /:i input \h* file/;
    like $err, /:i \h*  /;
}

#===================================
# Test 3
# out: 
# err: FATAL: Input file 't/data/FAKE.pdf' is NOT a PDF file.
#===================================
++$test; say "Test $test" if $debug;
$proc = run "bin/compress-pdf", "dpi=150", "t/data/FAKE.pdf", :out, :err;
$out = $proc.out.slurp(:close).lines.head // "";
$err = $proc.err.slurp(:close).lines.head // "";
if $debug {
    say "out: '$out'";;
    say "err: '$err'";;
}
else {
    like $out, /:i \h* /;
    like $err, /:i fatal  /;
}
