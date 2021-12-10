#!/usr/bin/perl

use strict;
use warnings;
use experimental 'smartmatch';

my %inverse = (
  '[' => ']',
  '{' => '}',
  '<' => '>',
  '(' => ')',
);

my %scores = (
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137,
);

open(my $file, '<', $ARGV[0]) or die('Could not open file');
chomp(my @lines = <$file>);
close($file);

my $score = 0;

for (@lines) {
  my @stack = ();
  foreach (split //, $_) {
    if ($_ ~~ ['[', '{', '(', '<']) {
      push(@stack, $_);
    } else {
      my $expected = $inverse{pop(@stack)};
      if ($_ ne $expected) {
        $score += $scores{$_};
        last;
      }
    }
  }
}

print($score . "\n");
