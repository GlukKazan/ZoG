while (<>) {
  chomp;
  if (/^(\S+)\s+(\d+)(\s+(\S+))?/) {
     my $nm = $1;
     my $vl = $2;
     my $im = $4;
     my $tp = "c-moves";
     if (!$im) {
        $im = $nm;
     }
     if ($nm =~ /L|D/) {
         $tp = "s-moves";
         if ($nm =~ /^R/) {
             $tp = "r-moves";
         }
         if ($nm =~ /^B/) {
             $tp = "b-moves";
         }
         if ($nm =~ /F/) {
             $tp = "j-moves";
         }
         if ($nm =~ /^RF/) {
             $tp = "R-moves";
         }
         if ($nm =~ /^RB/) {
             $tp = "B-moves";
         }
     }
     print "\t{piece}	$nm\t{moves} $tp\t$vl\t{value}\n";
  }
}