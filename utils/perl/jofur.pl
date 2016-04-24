while (<>) {
  chomp;
  if (/^(\S+)\s+(\d+)(\s+(\S+))?/) {
     my $nm = $1;
     my $vl = $2;
     my $im = $4;
     if (!$im) {
        $im = $nm;
     }
     print "  (p $im $nm) ; $vl\n";
  }
}