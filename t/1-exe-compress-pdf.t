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

plan 12;

my ($proc, $out, $err);

my $test = 0;

#===================================
# Test 1
# out: Input file: t/data/calendar.pdf
# err: 
#===================================
++$test; say "Test $test" if $debug;

$proc = run "bin/compress-pdf", "t/data/calendar.pdf", :out, :err;
$out = $proc.out.slurp(:close).lines.head // "";
# is $out a legit PDF file?

$err = $proc.err.slurp(:close).lines.head // "";
if 0 and $debug {
    say "out: '$out'";
    say "err: '$err'";
}
else {
    like $out, /:i input \h* file/;
    like $err, /:i \h*  /;
}

#done-testing;
#=finish

#===================================
# Test 2
# out: Input file: t/data/calendar.pdf
# err: 
#===================================
++$test; say "Test $test" if $debug;
$proc = run "bin/compress-pdf", "dpi=150", "t/data/calendar.pdf", :out, :err;
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
# out: Input file: t/data/calendar.pdf
# err: 
#===================================
++$test; say "Test $test" if $debug;
$proc = run "bin/compress-pdf", "dpi=300", "t/data/calendar.pdf", :out, :err;
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
# Test 4
# out: Input file: t/data/calendar.pdf
# err: 
#===================================
++$test; say "Test $test" if $debug;
$proc = run "bin/pdf-compress", "dpi=300", "t/data/calendar.pdf", :out, :err;
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
# Test 5
# out: 
# err: FATAL: dpi values must be 150 or 300, you entered '200'
#===================================
++$test; say "Test $test" if $debug;
$proc = run "bin/pdf-compress", "dpi=200", "t/data/calendar.pdf", :out, :err;
$out = $proc.out.slurp(:close).lines.head // "";
$err = $proc.err.slurp(:close).lines.head // "";
if $debug {
    say "out: '$out'";
    say "err: '$err'";
}
else {
    like $out, /:i \h* /;
    like $err, /:i fatal /;
}

#===================================
# Test 6
# out: 
# err: FATAL: Unknown arg 't/data/calendarFAKE.pdf' (not a valid file)
#===================================
++$test; say "Test $test" if $debug;
$proc = run "bin/pdf-compress", "t/data/calendarFAKE.pdf", :out, :err;
$out = $proc.out.slurp(:close).lines.head // "";
$err = $proc.err.slurp(:close).lines.head // "";
if $debug {
    say "out: '$out'";
    say "err: '$err'";
}
else {
    like $out, /:i \h* /;
    like $err, /:i fatal /;
}

