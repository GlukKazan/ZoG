my $min;
my $max;
my $sum = 0;
my $cnt = 0;
my $splash = 0;

while (<>) {
    if (/^\s*(\d+)\s*$/) {
        if ($cnt && ($1 > $min)) {
            $splash++;
        }
        if (!$cnt || ($1 < $min)) {
            $min = $1;
        }
        if (!$cnt || ($1 > $max)) {
            $max = $1;
        }
        $sum += $1;
        $cnt++;
    } else {
        if ($cnt) {
            my $avg = $sum / $cnt;
            print "$min, $avg, $max, $splash\n";
            $sum = 0;
            $cnt = 0;
            $splash = 0;
        }
    }
}
