#!/usr/bin/perl
use 5.18.0;
use warnings;
use strict;

my $filename = 'test_file.txt';

# generate random values as input for file

open(my $fh, '>', $filename) or die "Cannot Open File: $!";

for (1..100) {
    for my $j (1..8) {
        my $str = '';
        for (1..4) {
            $str = $str . int(rand(2));
        }
        if ($j < 8) {
            $str = $str. ' ';
        }
        else {
            $str = $str. qq(\n);
        }
        print $fh $str;
    }
}

close($fh);

# read the random values and output decimal values to new file

my $out_file = 'out.txt';
my $out_file2 = 'out2.txt';

open(my $fh2, '<', $filename) or die "Cannot Open File: $!";
open(my $fh3, '>', $out_file) or die "Cannot Open File: $!";
open(my $fh4, '>', $out_file2) or die "Cannot Open File: $!";

while (my $line = <$fh2>) {
    my @array = split /\s/, $line; # split on all whitespace, thats the reg expr for that
    for my $i (0..$#array) {
        my $x_num = oct("0b" . $array[$i]);
        print $fh4 "0x";
        print $fh4 sprintf('%X', $x_num);
        if ($x_num <= 9) {
            print $fh3 "0";
        }
        print $fh3 $x_num;
        if ($i == $#array) {
            print $fh3 "\n";
            print $fh4 "\n";
        } else {
            print $fh3 " ";
            print $fh4 " ";
        } 
    }
}

close($fh2);
close($fh3);
close($fh4);