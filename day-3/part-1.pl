#!/usr/bin/perl

use strict;
use warnings;

open(my $file, '<', $ARGV[0]) or die('Could not open file');
chomp(my @numbers = <$file>);
close($file);

my $gamma = join(
  '', 
  map {
    my $digit = $_;
    my $count = grep { substr($_, $digit, 1) eq '0' } @numbers;
    ($count > scalar(@numbers) / 2) ? '0' : '1'
  } (0..length($numbers[0]) - 1),
);

my $epsilon = join('', map({$_ == '0' ? '1' : '0'} split(//, $gamma)));

print((oct('0b'.$gamma) * oct('0b'.$epsilon)) . "\n");
