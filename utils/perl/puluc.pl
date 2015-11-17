#!/usr/bin/perl -w

my %nodes;
my %values;
my %links;

for (my $i = 0; $i < 0b11110000; $i++) {
     my ($n, $k, $c, $s, $r) = (0, 0, '', '', '');
     for (my $m = 0b10000000; $m > 0; $m >>= 1) {
         if ($i & $m) {
             $r .= 'W';
             $n ++;
             if ($c) {
                 $s .= $c;
             }
             $c = 'a';
         } else {
             if ($c) {
                 $k ++;
                 $c++;
                 $r .= 'B';
             }
         }
     }
     $s .= $c;
     if ($n <= 4 && $k <= 4 && $s) {
         $nodes{$r}  = $s;
         $values{$r} = $i;
     }
}

foreach $x (keys %nodes) {
     my $y = $x;
     $y =~ tr/WB/BW/;
     if ($nodes{'W' . $y}) {
         $links{$x}->{'a'} = $nodes{'W' . $y};
     }
     if ($nodes{'WB' . $y}) {
         $links{$x}->{'b'} = $nodes{'WB' . $y};
     }
     if ($nodes{'WBB' . $y}) {
         $links{$x}->{'c'} = $nodes{'WBB' . $y};
     }
     if ($nodes{'WBBB' . $y}) {
         $links{$x}->{'d'} = $nodes{'WBBB' . $y};
     }
}

printf "{moves move-pieces\n";
printf 		"\t{move} move-piece {move-type} normal\n";
printf "moves}\n\n";

printf "{pieces\n";
foreach $x (sort keys %nodes) {
	printf "\t{piece} $nodes{$x}\t{moves} move-pieces\t{value} $values{$x}\n";
}
printf "pieces}\n";
