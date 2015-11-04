#!/usr/bin/perl

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

# Tableau des liens
my @links;

#Parcours de chaque ligne du CSV
while (<>) {

	#Declaration de contrat, qui contient les infos d'un contrat
	# IDContrat, IDFilliale, IDMother, IDScreen1;...;IDScreenN, Industry(;),Intended Investment,Currency,Date,Type of document,
	# Document name,Document Cloud link,Company Notice,Document Notice,Accounting firm,Story 1 link,Story 1 text,Story 2 link,
	# Story 2 text,Story 3 link,Story 3 text,Story 4 link,Story 4 text,Story 5 link,Story 5 text
	my @contract = split(",", $_);
	
	# Tableau représentant la ligne d'un liens
	my @link;
	
	
}

while ((my $k, my $v) = each(%h)) {
	print "$v, $k\n";
}
# Corps du script

# les cellules sont séparées par des virgules (',')
# les valeurs d'une cellule multivaluée sont séparés par des points-virgules (';')
