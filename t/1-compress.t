use Test;
use Compress::PDF;

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

plan 12;

my ($proc, $out, $err, $debug);

$debug = 0;

my $test = 0;

#===================================
=begin comment
Test 1
out: Input file: t/data/calendar.pdf   Size: 2.9M Compressed output file: calendar-150dpi.pdf   Size: 247.7K
err:
=end comment
++$test; say "Test $test" if $debug;
$proc = run "bin/compress-pdf", "t/data/calendar.pdf", :out, :err;
$out = $proc.out.slurp(:close).lines.join(" ");
$err = $proc.err.slurp(:close).lines.join(" ");
if $debug {
    say "out: ", $out;
    say "err: ", $err;
}
else {
    like $out, /:i input \h* file/;
    like $err, /:i \h*  /;
}

#===================================
=begin comment
Test 2
out: Input file: t/data/calendar.pdf   Size: 2.9M Compressed output file: calendar-150dpi.pdf   Size: 247.7K
err:
=end comment
++$test; say "Test $test" if $debug;
$proc = run "bin/compress-pdf", "dpi=150", "t/data/calendar.pdf", :out, :err;
$out = $proc.out.slurp(:close).lines.join(" ");
$err = $proc.err.slurp(:close).lines.join(" ");
if $debug {
    say "out: ", $out;
    say "err: ", $err;
}
else {
    like $out, /:i input \h* file/;
    like $err, /:i \h*  /;
}

#===================================
=begin comment
Test 3
out: Input file: t/data/calendar.pdf   Size: 2.9M Compressed output file: calendar-300dpi.pdf   Size: 253.3K
err:
=end comment
++$test; say "Test $test" if $debug;
$proc = run "bin/compress-pdf", "dpi=300", "t/data/calendar.pdf", :out, :err;
$out = $proc.out.slurp(:close).lines.join(" ");
$err = $proc.err.slurp(:close).lines.join(" ");
if $debug {
    say "out: ", $out;
    say "err: ", $err;
}
else {
    like $out, /:i input \h* file/;
    like $err, /:i \h*  /;
}

#===================================
=begin comment
Test 4
out: Input file: t/data/calendar.pdf   Size: 2.9M Compressed output file: calendar-300dpi.pdf   Size: 253.3K
err:
=end comment
++$test; say "Test $test" if $debug;
$proc = run "bin/pdf-compress", "dpi=300", "t/data/calendar.pdf", :out, :err;
$out = $proc.out.slurp(:close).lines.join(" ");
$err = $proc.err.slurp(:close).lines.join(" ");
if $debug {
    say "out: ", $out;
    say "err: ", $err;
}
else {
    like $out, /:i input \h* file/;
    like $err, /:i \h*  /;
}


#===================================
=begin comment
Test 5
out:
err: FATAL: dpi values must be 150 or 300, you entered '200'   in sub run-compress at /usr/local/git-repos/my-public-modules/Compress-PDF/lib/Compress/PDF.rakumod (Compress::PDF) line 11   in block <unit> at bin/pdf-compress line 6
=end comment
++$test; say "Test $test" if $debug;
$proc = run "bin/pdf-compress", "dpi=200", "t/data/calendar.pdf", :out, :err;
$out = $proc.out.slurp(:close).lines.join(" ");
$err = $proc.err.slurp(:close).lines.join(" ");
if $debug {
    say "out: ", $out;
    say "err: ", $err;
}
else {
    like $out, /:i \h* /;
    like $err, /:i fatal /;
}

#===================================
=begin comment
Test 6
out:
err: FATAL: No input file was entered. Exiting.   in sub run-compress at /usr/local/git-repos/my-public-modules/Compress-PDF/lib/Compress/PDF.rakumod (Compress::PDF) line 26   in block <unit> at bin/pdf-compress line 6
=end comment
++$test; say "Test $test" if $debug;
$proc = run "bin/pdf-compress", "t/data/calendarFAKE.pdf", :out, :err;
$out = $proc.out.slurp(:close).lines.join(" ");
$err = $proc.err.slurp(:close).lines.join(" ");
if $debug {
    say "out: ", $out;
    say "err: ", $err;
}
else {
    like $out, /:i \h* /;
    like $err, /:i fatal /;
}

