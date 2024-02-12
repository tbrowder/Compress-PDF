use Test;
use Compress::PDF;

my @f = <
    calendar.pdf
    calendar-150dpi.pdf
    calendar-300dpi.pdf
>;

END {
    unlink $_ if $_.IO.e for @f;
}

lives-ok {
    shell "bin/compress-pdf t/data/calendar.pdf 1>/dev/null 2>/dev/null";
}

lives-ok {
    shell "bin/compress-pdf dpi=150 t/data/calendar.pdf 1>/dev/null 2>/dev/null";
}

lives-ok {
    shell "bin/compress-pdf dpi=300 t/data/calendar.pdf 1>/dev/null 2>/dev/null";
}

lives-ok {
    shell "bin/pdf-compress t/data/calendar.pdf 1>/dev/null 2>/dev/null";
}

dies-ok {
    shell "bin/pdf-compress dpi=200 t/data/calendar.pdf 1>/dev/null 2>/dev/null";
}

dies-ok {
    shell "bin/pdf-compress t/data/calendarFAKE.pdf 1>/dev/null 2>/dev/null";
}

done-testing;
