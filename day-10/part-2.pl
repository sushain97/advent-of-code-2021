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

my %values = (
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4,
);

open(my $file, '<', $ARGV[0]) or die('Could not open file');
chomp(my @lines = <$file>);
close($file);

my @scores = ();

for (@lines) {
  my @stack = ();
  my $illegal = 0;

  foreach (split //, $_) {
    if ($_ ~~ ['[', '{', '(', '<']) {
      push(@stack, $_);
    } else {
      my $expected = $inverse{pop(@stack)};
      if ($_ ne $expected) {
        $illegal = 1;
        last;
      }
    }
  }

  if (!$illegal && scalar(@stack) != 0) {
    my $score = 0;
    foreach (reverse(@stack)) {
      $score *= 5;
      $score += $values{$inverse{$_}};
    }
    push(@scores, $score);
  }
}

@scores = sort { $a <=> $b } @scores;
print($scores[scalar(@scores) / 2] . "\n");
