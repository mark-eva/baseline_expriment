#!/usr/bin/perl
use warnings;
use strict;

our $cmd_multiple_exec="echo \@execute_multiple_times.sql | sqlplus / as sysdba";
print "$cmd_multiple_exec\n";

my @a = (1..10000);
for my $i (@a){
`$cmd_multiple_exec`;
	
}
