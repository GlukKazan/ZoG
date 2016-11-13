my $a;

while (<>) {
  if (/\(define\s+(\w+)-step\s+\(/) {
     $a = uc($1);
  }
  if (/\(add-2\s+(\w+)\s+(\w+)\)(\s*;\s*(\w+))?/) {
     my $b = $1;
     my $c = $2;
     my $d = $4;
     my @x = sort(split('', $a . $b));
     my @y = sort(split('', $c . $d));
     my $x = sprintf "@x";
     my $y = sprintf "@y";
     if ($x ne $y) {
        print "$a,$b,$c,$d\n";
     }
  }
}
