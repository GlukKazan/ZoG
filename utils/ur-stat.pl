#!/usr/bin/perl -w

my @S = (0, 0, 0, 0, 0, 0);
my $ix = 0;
my $T;

while (<>) {
    if (/results/) {
        my $d = $S[0] - $S[1];
        print "$T, $d, $S[3], $S[2], $S[4], $S[5]\n";
        @S = (0, 0, 0, 0, 0, 0);
        $ix = 0;
    } else {
        if (/^(\d+)\.\s+[^?].*$/) {
             $T = $1;
             if (/x h3/) {
                 $S[$ix]++;
             }
             if (/Pass|^(\d+)\.\s+x\s+q5\s*$/) {
                 $S[$ix + 2]++;
             }
             if (/Black init [ijklmno]5/) {
                 $S[4]++;
             }
             if (/White init [ijklmno]1/) {
                 $S[5]++;
             }
             $ix++;
             if ($ix > 1) {
                 $ix = 0;
             }
        }
    }
}
