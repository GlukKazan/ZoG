my $cn = 0;
my $cp = 0;
my $rc = 0;
my $bc = 0;
my $lc = 0;
my $lb = 0;

while (<>) {
   chomp;
   if (/^(\d+)\.\s*(.+)$/) {
       my $n = $1;
       my $s = $2;
       $cp++;
       if ($cn > $n) {
           if ($cp == 1) {
               print "$cn;1;$lc;$lb;0;0;0;$rc;$bc\n";
           } else {
               print "$cn;0;0;0;1;$lc;$lb;$rc;$bc\n";
           }
           $cn = 0;
           $rc = 0;
           $bc = 0;
           $lc = 0;
           $lb = 0;
       }
       if ($s =~ /[-x]\s+[a-j][18]/) {
           $lb = 1;
       } else {
           $lb = 0;
       }
       if ($s =~ /^\s*Man\s+[a-j][1-8]\s+x\s+[a-j][1-8]\s*$/) {
           if ($cp == 1) {
               $rc++;
           } else {
               $bc++;
           }
           $lc = 1;
       } else {
           $lc = 0;
       }
       if ($cn < $n) {
           $cp = 0;
       }
       $cn = $n;
   }
}

$cp++;
if ($cp == 1) {
    print "$cn;1;$lc;$lb;0;0;0;$rc;$bc\n";
} else {
    print "$cn;0;0;0;1;$lc;$lb;$rc;$bc\n";
}
