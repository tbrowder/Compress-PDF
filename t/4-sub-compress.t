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
    calendar2
    calendar.txt
    t/data/calendar
    t/data/calendar.txt
>;
END { unlink $_ if $_.IO.e for @f; }

# Prepare three more temporary input files
# Genuine PDF files
my $f  = "t/data/calendar.pdf"; # permanent
my $f0 = "t/data/calendar";     # test copy
my $fx = "t/data/calendar.txt"; # test copy
# One fake file
my $fX = "t/data/FAKE.pdf";     # permanent

cp $f, $f0;
cp $f, $fx;

my ($proc, $out, $err);

plan 8;

# good
lives-ok { compress $f; }
lives-ok { compress $f0; }
lives-ok { compress $fx; }

# fake
dies-ok { compress $fX; }

# with good args
lives-ok { compress $f, :dpi(150); }
lives-ok { compress $f, :dpi(300); }
lives-ok { compress $f, :outpdf($f0), :force }

# bad args
dies-ok { compress $f, :outpdf($f0) }
