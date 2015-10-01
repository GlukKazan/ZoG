open(my $f, '>', 'levels_1_10.zrf');

my $n = 0;
my $k = 0;
my $x = 0;
my $y = 0;
my %p;

while (<>) {
  chomp;
  my $s = $_;
  if (/^\s*X/) {
     $y++;
     my $i = 0;
     my @a = split(//, $s);
     foreach $c (@a) {
         $i++;
         if ($c ne ' ') {
             my $p;
             if ($i > 26) {
                 $p = chr(ord('A') + $i - 27);
             } else {
                 $p = chr(ord('a') + $i - 1);
             }
             my $key = $p . $y;
             $c =~ tr/X*.@/WBTY/;
             $p{$key} = $c;
             if ($i > $x) {
                 $x = $i;
             }
         }
     }
  } else {
     if ($y) {
         $n++;
         if ($n > 10) {
             $k++;
             $n = 1;
             close($f);
             my $a = $k * 10 + 1;
             my $b = ($k + 1) * 10;
             open($f, '>', "levels_${a}_${b}.zrf");
         }
         my $l = $k * 10 + $n;
         if ($n > 1) {
             printf $f "(variant\n";
         } else {
             printf $f "(include \"sokoban.zrf\")\n\n";
             printf $f "(game\n";
         }
         printf $f "   (title \"Sokoban (Level $l)\")\n";
         printf $f "   (common-level)\n";
         printf $f "   (board\n";
         printf $f "      (common-board)\n";
         printf $f "      (grid\n";
         printf $f "         (common-grid)\n";
         printf $f "         (dimensions\n";
         printf $f "              (\"";
         for (my $i = 1; $i <= $x; $i++) {
             if ($i > 1) {
                 printf $f "/";
             }
             my $p;
             if ($i > 26) {
                 $p = chr(ord('A') + $i - 27);
             } else {
                 $p = chr(ord('a') + $i - 1);
             }
             printf $f "$p";
         }
         printf $f "\" (49 0)) ; files\n";
         printf $f "              (\"";
         for (my $i = 1; $i <= $y; $i++) {
             if ($i > 1) {
                 printf $f "/";
             }
             printf $f "$i";
         }
         printf $f "\" (0 49)) ; ranks\n";
         printf $f "         )\n";
         printf $f "      )\n";
         printf $f "   )\n";
         printf $f "   (board-setup\n";
         printf $f "      (You\n";
         printf $f "         (W";
         foreach $pos (keys %p) {
             if ($p{$pos} eq 'W') {
                 printf $f " $pos";
             }
         }
         printf $f ")\n";
         printf $f "         (B";
         foreach $pos (keys %p) {
             if ($p{$pos} eq 'B') {
                 printf $f " $pos";
             }
         }
         printf $f ")\n";
         printf $f "         (T";
         foreach $pos (keys %p) {
             if ($p{$pos} eq 'T') {
                 printf $f " $pos";
             }
         }
         printf $f ")\n";
         printf $f "         (Y";
         foreach $pos (keys %p) {
             if ($p{$pos} eq 'Y') {
                 printf $f " $pos";
             }
         }
         printf $f ")\n";
         printf $f "      )\n";
         printf $f "   )\n";
         printf $f ")\n\n";
         $x = 0;
         $y = 0;
         %p = ();
     }
  }
}

close($f);
