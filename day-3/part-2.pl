#!/usr/bin/perl

use strict;
use warnings;

open(my $file, '<', $ARGV[0]) or die('Could not open file');
chomp(my @numbers = <$file>);
close($file);

my $cursor = 0;
my @oxygen_numbers = @numbers;
while (scalar(@oxygen_numbers) > 1) {
  my $zero_count = grep { substr($_, $cursor, 1) eq '0' } @oxygen_numbers;
  my $keep = ($zero_count > scalar(@oxygen_numbers) / 2) ? '0' : '1';
  @oxygen_numbers = grep { substr($_, $cursor, 1) eq $keep } @oxygen_numbers;
  $cursor++;
}
my $oxygen = $oxygen_numbers[0];

$cursor = 0;
my @co2_numbers = @numbers;
while (scalar(@co2_numbers) > 1) {
  my $zero_count = grep { substr($_, $cursor, 1) eq '0' } @co2_numbers;
  my $keep = ($zero_count > scalar(@co2_numbers) / 2) ? '1' : '0';
  @co2_numbers = grep { substr($_, $cursor, 1) eq $keep } @co2_numbers;
  $cursor++;
}
my $co2 = $co2_numbers[0];

print((oct('0b'.$oxygen) * oct('0b'.$co2)) . "\n");
