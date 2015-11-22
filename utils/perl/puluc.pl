#!/usr/bin/perl -w

my %nodes;
my %names;
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
         $names{$i}  = $r;
     }
}

foreach my $x (keys %nodes) {
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

printf "DEFER\tmove-piece\n";
printf "DEFER\tclear-dice\n";
printf "DEFER\tdrop-dice\n\n";

printf "{move-priorities\n";
printf "\t{move-priority} normal-type\n";
printf "\t{move-priority} pass-type\n";
printf "move-priorities}\n\n";

printf "{moves move-pieces\n";
printf "\t{move} move-piece\t{move-type} normal-type\n";
printf "\t{move} Pass\t\t{move-type} pass-type\n";
printf "moves}\n\n";

printf "{moves clear-dices\n";
printf "\t{move} clear-dice\t{move-type} clear-type\n";
printf "moves}\n\n";

printf "{moves drop-dices\n";
printf "\t{move} drop-dice\t{move-type} dice-type\n";
printf "moves}\n\n";

printf "{pieces\n";
printf "\t{piece} mark\t{moves} clear-dices\n";
printf "\t{piece} zero\t{moves} drop-dices\t0\t{value}\n";
printf "\t{piece} one\t{moves} drop-dices\t1\t{value}\n";
foreach my $x (sort keys %nodes) {
	printf "\t{piece} $nodes{$x}\t{moves} move-pieces\t$values{$x}\t{value}\n";
}
printf "pieces}\n\n";

sub lpad {
	my ($str, $len, $chr) = @_;
	$chr = " " unless (defined($chr));
	return substr(($chr x $len) . $str, -1 * $len, $len);
}

printf ": puluc-head ( -- piece-type )\n";
printf "\tpiece piece-value mark\n";
foreach my $value (sort keys %names) {
	my $name = $names{$value};
	my $node = $nodes{$name};
	my $res  = substr($node, 0, 1);
	$value   = lpad($value, 4);
	printf "\tOVER $value = IF DROP $res ENDIF\n";
}
printf "\tSWAP DROP\n";
printf "\tDUP mark > verify\n";
printf ";\n\n";

printf ": puluc-tail ( -- piece-type )\n";
printf "\tpiece piece-value mark\n";
foreach my $value (sort keys %names) {
	my $name = $names{$value};
	my $node = $nodes{$name};
	my $res  = substr($node, 1);
	if ($res) {
		$res   = lpad($res, 5);
		$value = lpad($value, 4);
		printf "\tOVER $value = IF DROP $res ENDIF\n";
	}
}
printf "\tSWAP DROP\n";
printf ";\n\n";

sub puluc_cons {
	my ($piece) = @_;
	printf ": $piece-cons ( -- piece-type )\n";
	printf "\tpiece piece-value mark\n";
	foreach my $value (sort keys %names) {
		my $name = $names{$value};
		my $node = $nodes{$name};
		if ($links{$name}->{$piece}) {
			$res   = lpad($links{$name}->{$piece}, 5);
			$value = lpad($value, 4);
			printf "\tOVER $value = IF DROP $res ENDIF\n";
		}
	}
	printf "\tSWAP DROP\n";
	printf ";\n\n";
}

puluc_cons('a');
puluc_cons('b');
puluc_cons('c');
puluc_cons('d');

printf ": puluc-cons ( piece-type -- piece-type )\n";
printf "\tDUP a = IF a-cons ENDIF\n";
printf "\tDUP b = IF b-cons ENDIF\n";
printf "\tDUP c = IF c-cons ENDIF\n";
printf "\tDUP d = IF d-cons ENDIF\n";
printf "\tSWAP DROP\n";
printf "\tDUP mark > verify\n";
printf ";\n";
