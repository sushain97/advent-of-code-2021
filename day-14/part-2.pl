#!/usr/bin/perl

use strict;
use warnings;

open(my $file, '<', $ARGV[0]) or die('Could not open file');
chomp(my @lines = <$file>);
close($file);

my %pairCounts = ();
for (my $i = 0; $i < length($lines[0]) - 1; $i++) {
  $pairCounts{substr($lines[0], $i, 2)}++;
}

my %rules = ();
for (my $i = 2; $i < scalar(@lines); $i++) {
  my @rule = split(' -> ', $lines[$i]);
  $rules{$rule[0]} = $rule[1];
}

for (my $i = 0; $i < 40; $i++) {
  my %newPairCounts = ();
  while(my($pair, $count) = each %pairCounts) {
    $newPairCounts{substr($pair, 0, 1).$rules{$pair}} += $count;
    $newPairCounts{$rules{$pair}.substr($pair, 1, 1)} += $count;
  }
  %pairCounts = %newPairCounts;
}

my %letterCounts = ();
keys %pairCounts;
while(my($pair, $count) = each %pairCounts) {
  $letterCounts{substr($pair, 0, 1)} += $count;
  $letterCounts{substr($pair, 1, 1)} += $count;
}
$letterCounts{substr($lines[0], 0, 1)}++;
$letterCounts{substr($lines[0], length($lines[0]) - 1, 1)}++;

my @counts = sort {$a <=> $b} values %letterCounts;
printf("%d\n", int($counts[-1] / 2) - int($counts[0]) / 2);
