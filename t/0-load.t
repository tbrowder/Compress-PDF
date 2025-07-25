use Test;

my @modules = <
    Compress::PDF;
>;

plan @modules.elems;

for @modules -> $m {
    use-ok $m, "Module '$m' used okay";
}
