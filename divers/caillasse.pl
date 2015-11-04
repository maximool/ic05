#!/usr/bin/perl

#TODO deprecated script

# En-tête
## Encodage
binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8"); 
## Modules
use Text::CSV;
## Pragma
use strict;
use warnings;

# Fonctions
sub convert {
	my $var = pop @_;
#	$var =~ tr/A-Z/a-z/;
	$var =~ s/ü/u/g;
	$var =~ s/ä/a/g;
	$var =~ s/ö/o/g;
	$var =~ s/Ö/o/g;
	$var =~ s/Ä/a/g;
	$var =~ s/É/é/g;
	$var =~ s/é/e/g;
	return $var;
}
sub money {
	my @li = split(" ", $_[0]);
	return $li[0];
}

# Corps du script
## Pointeurs sur fichiers
my $ll = "../sources/luxleakscorrected.csv";
my $ei = "../entreprises/entreprisesids.csv";
my $cc = "caillasse.csv";
open (EICSV, "<", $ei) or die "A fuck happened while opening $ei\n";
open (LLCSV, "<", "$ll") or die "A fuck happened while opening $ll\n";
my $csv = Text::CSV->new({
	binary => 1,
	auto_diag => 1,
	sep_char => ','
});
my %h = {};
while (<EICSV>) {
	if ($csv->parse($_)) {
		my @tab = $csv->fields();
		my $ent = convert $tab[0];
		$h{$ent} = 0.0;
		open (LLCSV, "<", "$ll") or die "A fuck happened while opening $ll";
		while (<LLCSV>) {
			if ($csv->parse($_)) {
				my @lin = $csv->fields();
				my $tmpent = convert $lin[1];
				my $tmpinv;
				($lin[7] eq "") ? $tmpinv = 0.0 : $tmpinv = $lin[7];
				if ($ent eq $tmpent) {
					$tmpinv = money $tmpinv;
					$h{$ent} += $tmpinv;
				}
			}
			else {
				die "A fuck happened while parsing $ei\n";
			}
		}
		close LLCSV;
	}
	else {
		die "A fuck happened while parsing $ei\n";
	}
}
close EICSV;
open (CCCSV, ">", "$cc") or die "A fuck happened while opening $cc";
my @sortedKeys = sort ({$a cmp $b} keys(%h));
foreach my $key (@sortedKeys) {
	print CCCSV "$key, ${$key}\n";
}
close CCCSV;
