use Test;
use Compress::PDF;

lives-ok {
    shell "bin/compress-pdf t/data/calendar.pdf";
}

lives-ok {
    shell "bin/pdf-compress t/data/calendar.pdf";
}

done-testing;
