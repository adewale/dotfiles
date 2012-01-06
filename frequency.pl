#!/usr/bin/perl
# Obtained from: http://matt.might.net/articles/console-hacks-exploiting-frequency/ and written by Matt Might

my %counts = () ;
 
while (my $cmd = <STDIN>) {
    chomp $cmd ;
    if (!$counts{$cmd}) {
        $counts{$cmd} = 1 ;
    } else {
        $counts{$cmd}++ ;
    }
}
 
foreach $k (keys %counts) {
    my $count = $counts{$k} ;
    print "$count $k\n" ;
}
