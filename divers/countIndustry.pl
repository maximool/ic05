#!/usr/bin/perl

# à lancer en faisant `perl countIndustry ../sources/luxleakscorrected.csv > ci.csv`

# En-tête
## Encodage
binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8"); 
## Pragma
use strict;
use warnings;

# Fonctions
sub convert {
	my $var = pop @_;
	$var =~ tr/A-Z/a-z/;
	$var =~ s/ü/u/g;
	$var =~ s/ä/a/g;
	$var =~ s/ö/o/g;
	$var =~ s/Ö/o/g;
	$var =~ s/Ä/a/g;
	$var =~ s/É/é/g;
	$var =~ s/é/e/g;
	return $var;
}
sub splitIndustries {
	my $var = pop @_;
	if ($var =~ m/\w*;\w*/) {
		my @liste = split(";", $var);
		print STDOUT "@liste\n";
#		return $var;
	}
	else {
		print STDOUT "$var\n";
#		return $var;
	}
}
# Corps du script
while (<>) {
	my @tab = split(",", $_);
	splitIndustries(convert $tab[6]);
}
print `cat ci.csv | grep -i "energy" | wc -l`;
