my @d;
my %s;

sub out {
  my ($deep) = @_;
  for (my $i = 0; $i < $deep; $i++) {
      printf "$d[$i]";
  }
  printf "\n";
}

sub alloc {
  my ($x, $deep, $res) = @_;
  if ($x == 0) {
      $s{$res}++;
  } else {
      my $vl = 6;
      for (my $i = 0; $i < $deep; $i++) {
         if ($d[$i] < $vl) {
             $vl = $d[$i];
         }
      }
      if ($vl < 6) {
         my $cn = 0;
         my $ix = 0;
         for (my $i = 0; $i < $deep; $i++) {
             if ($d[$i] == $vl) {
                $cn++;
                $ix = $i;
             }
         }
         my $y = $d[$ix]; $d[$ix] = 6;
         $x -= 6 - $vl;
         if ($x < 0) {
             $x = 0;
         }
         alloc($x, $deep, $res * 10 + $cn);
         $d[$ix] = $y;
      }
  }
}

sub dice {
  my ($start, $deep, $sum) = @_;
  if ($sum == 25) {
     for (my $i = 0; $i < $deep; $i++) {
         my $x = $d[$i]; $d[$i] = 6;
         alloc($x, $deep, 0);
         $d[$i] = $x;
     }
  }
  if ($deep < 10 && $sum < 25) {
     for (my $i = $start; $i <= 6; $i++) {
         $d[$deep] = $i;
         dice($i, $deep + 1, $sum + $i);
     }
  }
}

dice(1, 0, 0);

my $all;

foreach my $k (sort { $s{$a} <=> $s{$b} } keys %s) {
  $all += $s{$k};
  printf "$k\t=> $s{$k}\n";
}

printf "\n$all\n";
