use Test;
use Compress::PDF;
use File::Copy;

my $debug = 1;

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
# Genuine PDF files
my $f  = "t/data/calendar.pdf";
my $f0 = "t/data/calendar";
my $fx = "t/data/calendar.txt";
# One fake file
my $fX = "t/data/FAKE.pdf";

cp $f, $f0;
cp $f, $fx;

my ($proc, $out, $err);

my $test = 0;

plan 4;

my $res;

# good
for $f, $f0, $fx -> $f {
    $res = isa-pdf-file $f, :$debug;
    is $res.so, True;
}

# fake
$res = isa-pdf-file $fX, :$debug;
is $res.so, False;
