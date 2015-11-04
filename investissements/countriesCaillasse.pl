#!/usr/bin/perl

# En-tête
## Encodage
binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8"); 
## Pragma
use strict;
use warnings;

# Corps du script
## Fichiers utilisés
my $ll = "luxleakscorrectednoheader.csv";
my $co = "realCountries.csv";
## Récupération de la liste des pays
open (COCSV, "<", "$co") or die "A fuck happened while opening $co";
my %h;
while (<COCSV>) {
	chomp;
	my $countriesList = $_;
	my @countries = split(';', $countriesList);
	foreach my $country (@countries) {
		$h{$country} = 0.0;
	}
}
close COCSV;
## Calcul des montants par pays
foreach my $country (keys(%h)) {
	open (LLCSV, "<", "$ll") or die "A fuck happened while opening $ll";
	while(<LLCSV>) {
		my @line = split(',', $_);
		my @line4 = split(';', $line[4]);
		if (grep {$_ eq $country} @line4) {
			my $tmpinv = $line[7];
			my @elements = split(' ', $tmpinv);
			for (my $i = 0 ; $i < scalar(@elements) ; $i++) {
				if ($elements[$i] =~ m/\d+(\.\d*)?/) {
					if ($line[8] eq "USD") {$elements[$i] *= 0.886;}
					elsif ($line[8] eq "EUR") {$elements[$i] *= 1.0;}
				        elsif ($line[8] eq "GBP") {$elements[$i] *= 1.36;}
				}
				elsif ($elements[$i] eq "billion") {
					$elements[$i-1] *= 1000000000.0;
					$elements[$i] = "";
				}
				elsif ($elements[$i] eq "million") {
					$elements[$i-1] *= 1000000.0;
					$elements[$i] = "";
				}
				else {$elements[$i] = "";}
			}
			my $total = 0.0;
			for (my $i = 0 ; $i < scalar(@elements) ; $i++) {
				if ($elements[$i] ne "") {
					$total += $elements[$i];
				}
			}
			$h{$country} += $total;
		}
	}
	close LLCSV;
}
my @sortedCountries = sort {$a cmp $b} keys(%h);
foreach my $country (@sortedCountries) {
	print STDOUT "$country,$h{$country}\n";
}
