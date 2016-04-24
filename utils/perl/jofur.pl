while (<>) {
  chomp;
  if (/^(\S+)\s+(\d+)(\s+(\S+))?/) {
     my $nm = $1;
     my $vl = $2;
     my $im = $4;
     if (!$im) {
        $im = $nm;
     }
     print "\t{piece}	$nm\t{moves} common-moves\t$vl\t{value}\n";
  }
}