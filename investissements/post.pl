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
	$var =~ s/"//;
	$var =~ s/ , /,/;
	$var =~ s/(\w),(\w)/$1;$2/;
	$var =~ s/(\d)\.(\d)/$1,$2/;
	return $var;
}

# Corps du script
my @tab = ();
open (FILEHANDLE, "<", $ARGV[0]);
while (<FILEHANDLE>) {
	chomp;
	push (@tab, convert $_);
}
close FILEHANDLE;
open (FILEHANDLE, ">", $ARGV[0]);
foreach my $element (sort {$a cmp $b} @tab) {
	print FILEHANDLE "$element\n";
}
close FILEHANDLE;
