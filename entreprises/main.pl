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
sub splitCountries {
	my $var = pop @_;
	if ($var =~ m/\w*;\w*/) {
		my @liste = split(";", $var);
		print STDOUT "@liste\n";
		#TODO
		return $var;
	}
	else {
		return $var;
	}
}
# Corps du script
## Pointeurs sur fichiers
my $ll = "../sources/luxleakscorrected.csv";
my $ei = "entreprisesids.csv";
my $nt = "newtable.csv";
open (LLCSV, "<", "$ll") or die "A fuck happened while opening $ll";
open (EICSV, ">", $ei) or die "A fuck happened while opening $ei";
## Lecture et traitement du csv
my %h;
my $id = 0;
while (<LLCSV>) {
	my @tab = split(",", $_);
	my $ent = convert $tab[1];
	my $par = convert $tab[2];
	my $cou = splitCountries (convert $tab[4]);
	my $ind = convert $tab[6];
	if ((!exists($h{$ent})) && ($ent ne "")) {
		$h{$ent} = $id;
		# Version avec id
#		print EICSV "$id,$ent,$par,$cou,$ind\n";
		# Version sans id
		print EICSV "$ent,$par,$cou,$ind\n";
		$id++;
	}
}
close EICSV;
close LLCSV;
open (LLCSV, "<", "$ll") or die "A fuck happened while opening $ll";
open (NTCSV, ">", $nt) or die "A fuck happened while opening $nt";
while (<LLCSV>) {
	my @tab = split(",", $_);
	my $env = convert $tab[1];
	if ($h{$env} != "0" || '0' || 0) {
		print NTCSV "$id,$h{$env},"; # version corrigée
		$id++;
	}
	else {
		print NTCSV "ContractID,CompanyID,";
	}
	for (my $i = 2 ; $i < scalar @tab - 1 ; $i++) {
		print NTCSV "$tab[$i],";
	}
	print NTCSV "$tab[scalar @tab - 1]";
}
close NTCSV;
close LLCSV;
