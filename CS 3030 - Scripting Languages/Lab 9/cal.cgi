#!/usr/bin/perl -T
#
# CS 3030 Scripting
# Lab 9 - CGI
# Mick Zeller
#
use 5.010;
use CGI;
use CGI::Carp qw/fatalsToBrowser/;

use strict;
use warnings;

# THIS @months ARRAY MIGHT BE USEFUL :-)
my @months = qw(january february march april may june july august september october november december);

my $q = CGI->new();
say $q->header(), $q->start_html(-title=>'Calendar');

for my $param ($q->param()) {
    my $safe_param = $q->escapeHTML($param);

    for my $value ($q->param($param)) {
		my $params = $q->escapeHTML($value);
		{
			local $ENV{"PATH"} = "/bin:/usr/local/bin:/usr/bin";
			local $ENV{"BASH_ENV"}="";
			my $date = "";
			my $month = "";
      my $year = "";
			# If $params is empty or all white space, set $date to a single space
      if($params eq "")
      {
        $date = " ";
      }
			# If $params is only a single 1-4 digit year, set $date to year
      if($params =~ /^\s*(\d{1,4})\s*$/)
      {
        $date = $1;
      }
			# If $params is a 1-4 digit month and a 1-4 digit year set $date to month and year
      if($params =~ /^\s*(\d{1,4}\s+(\d{1,4}))\s*$/)
      {
        $month = $1;
        $year = $2;
        if(("$month" > 0) && ("$month" < 13))
        {
          $date = "$month $year";
        }
      }
			# If $params is a 3 or more alpha char month and a 1-4 digit year, set $date to month and year
      if($params =~ /^\s*([a-zA-Z]{3,})\s+(\d{1,4})\s*$/)
      {
            $month = $1;
            $year = $2;

            if(grep {$_ =~ /^month/i } @months)
            {
              $date = "$month $year";
            }
      }
			if  ($date eq "") {
				say "<h1>Invalid Parameters: $params</h1>";
			} else {
				say "<h1>Parameters: $params</h1>";
			}
			my $cmds = "cal -h " . $date;
			my @lines = `$cmds`;
			say ("<pre>");
			for my $line (@lines) {
				print ("$line");
			}
			say ("</pre>");
		}
    }
    say '</p>';
}

say $q->end_html();

