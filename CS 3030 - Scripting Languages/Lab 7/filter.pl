#!/usr/bin/perl

# Mick Zeller
# Lab7 - Perl Filter
# CS 3030 - Scripting


if (@ARGV != 2)
{
   print STDERR "Usage: ./filter.pl 'FROMSTRING' 'TOSTRING'\n";
   error(1);
}

$from = $ARGV[0];
$to = $ARGV[1];

while(<STDIN>)
{
   eval "s/$from/$to/g";
   print;
}
