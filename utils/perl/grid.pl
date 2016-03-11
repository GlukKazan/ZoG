my @grid;
my %kp;
my $sx, $sy, $dx, $dy;
my $dm = 0;

while (<>) {
  if (/\(start-rectangle\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\)/) {
     $sx = $1; 
     $sy = $2;
     $dx = $3 - $1;
     $dy = $4 - $2;
  }
  if (/\(\"([^\"]+)\"\s+\((-?\d+)\s+(-?\d+)\)\)/) {
     my @a = split(/\//, $1);
     $grid[$dm]->{ix} = \@a;
     $grid[$dm]->{x}  = $2;
     $grid[$dm]->{y}  = $3;
     $dm++;
  }
  if (/\(kill-positions/) {
     $fl = 1;
  }
  if ($fl) {
     if (/\s(([a-z0-9]{1,2}\s+)+)/i) {
        my @a = split(/\s+/, $1);
        foreach my $p (@a) {
           $kp{$p} = 1;
        }
     }
     if (/\)/) {
        $fl = 0;
     }
  }
}

sub try {
  my ($ix, $pos, $x, $y) = @_;
  if ($ix < $dm) {
     my $i = 0;
     foreach my $p (@{$grid[$ix]->{ix}}) {
        try($ix + 1, $pos . $p, $x + $i * $grid[$ix]->{x}, $y + $i * $grid[$ix]->{y});
        $i++;
     }
  } else {
     if (!$kp{$pos}) {
         my $a = $sx + $x;
         my $b = $sy + $y;
         my $c = $a + $dx;
         my $d = $b + $dy;
         print "             ";
         printf "($pos %3d %3d %3d %3d)\n", $a, $b, $c, $d;
     }
  }
}

try(0, '', 0, 0);
