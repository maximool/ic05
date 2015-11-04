#!/usr/bin/perl

# En-tête
## Encodage
binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8"); 
## Pragma
use strict;
use warnings;


# Corps du script
## Prototype pour chaque requête
#my @tab = `psql dbmaxime -c "copy (select id, etad from luxleaks order by id) to stdout with csv;"`;
#for (my $i = 0 ; $i < scalar @tab ; $i++) {
#	print $tab[$i];
#}
## L'argent
my @money = `psql dbmaxime -c "copy (select intendedinvestment, currency from luxleaks) to stdout with csv;"`;
for (my $i = 0 ; $i < scalar @money ; $i++) {
	my $element = $money[$i];
	chomp $element;
	my @columns = split(",", $element);
	if ($columns[0]) {
		my @atoms = split (" ", $columns[0]);
		for (my $j = 0 ; $j < scalar @atoms ; $j++) {
			if ($atoms[$j] =~ m/\d+(\.\d*)?/) {
				if ($columns[1] eq "AUD") {$atoms[$j] *= 0.686;}
				elsif ($columns[1] eq "CHF") {$atoms[$j] *= 0.952;}
				elsif ($columns[1] eq "DKK") {$atoms[$j] *= 0.133;}
				elsif ($columns[1] eq "EUR") {$atoms[$j] *= 1.00;}
				elsif ($columns[1] eq "GBP") {$atoms[$j] *= 1.36;}
				elsif ($columns[1] eq "NOK") {$atoms[$j] *= 0.114;}
				elsif ($columns[1] eq "SEK") {$atoms[$j] *= 0.106;}
				elsif ($columns[1] eq "USD") {$atoms[$j] *= 0.886;}
			}
			elsif ($atoms[$j] eq "billion") {
				$atoms[$j-1] *= 1000000000.0;
				$atoms[$j] = "";
			}
			elsif ($atoms[$j] eq "million") {
				$atoms[$j-1] *= 1000000.0;
				$atoms[$j] = "";
			}
			else {$atoms[$j] = "";} 
		}
		my $total = 0.0;
		foreach my $atom (@atoms) {
			print "$atom\n" if $atom ne "";
		}
	}
}
