#!/usr/bin/perl -w
# Mick Zeller
# Lab 8 - Sockets
# CS3030

use IO::Socket;

if (@ARGV != 2)
{
	print STDERR "Usage: ./socket.pl HOSTNAME SOCKETNUMBER\n";
	exit(1);
}

$hostName = $ARGV[0];
$socketNumber = $ARGV[1] + 0;

$remote = IO::Socket::INET->new(
	Proto => "tcp",
	PeerAddr => $hostName,
	PeerPort => "socket($socketNumber)",)
	or die print STDERR "Error : cannont connect to ssh port at localhost";

$line = <$remote>;
print $line;
