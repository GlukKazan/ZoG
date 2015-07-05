#!/usr/bin/perl -w

my %stat;

while (<>) {
    if (/^\d+\.\s+\?Dice ([wb])dice q(\d)/) {
	$stat{$2}->{$1}++;
    }
}

$stat{'2'}->{'p'} = 100 * $stat{'2'}->{'w'} / ($stat{'2'}->{'w'} + $stat{'2'}->{'b'});
$stat{'3'}->{'p'} = 100 * $stat{'3'}->{'w'} / ($stat{'3'}->{'w'} + $stat{'3'}->{'b'});
$stat{'4'}->{'p'} = 100 * $stat{'4'}->{'w'} / ($stat{'4'}->{'w'} + $stat{'4'}->{'b'});

print "$stat{'2'}->{'p'}\n";
print "$stat{'3'}->{'p'}\n";
print "$stat{'4'}->{'p'}\n";
