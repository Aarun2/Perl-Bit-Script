#!/usr/bin/perl
use 5.18.0;
use warnings;
use strict;

# A method that helps generate random values for given lines and numbers per line
sub rand_bin_file {
    my $input = shift;
    my $num_lines = shift;
    my $num_per_line = shift;

    open(my $fh, '>', $input) or die "Cannot Open Input File: $!";

    for (1..$num_lines) {
        for my $j (1..$num_per_line) {
            my $str = '';
            for (1..4) {
                $str = $str . int(rand(2));
            }
            if ($j < $num_per_line) {
                $str = $str. ' ';
            }
            else {
                $str = $str. qq(\n);
            }
            print $fh $str;
        }
    }
    close($fh);
}

# A method that helps covert a binary input file to decimal
# adds leading zeroes to output for consistency
sub bin_file_to_dec_file {
    my $input = shift;
    my $output = shift;

    open(my $fh, '<', $input) or die "Cannot Open Input File: $!";
    open(my $fh2, '>', $output) or die "Cannot Open Output File: $!";

    while (my $line = <$fh>) {
        my @array = split /\s/, $line; # split on all whitespace, thats the reg expr for that
        for my $i (0..$#array) {
            my $x_num = oct("0b" . $array[$i]);
            if ($x_num <= 9) {
                print $fh2 "0";
            }
            print $fh2 $x_num;
            if ($i == $#array) {
                print $fh2 "\n";
            } else {
                print $fh2 " ";
            } 
        }
    }   

    close($fh2);
    close($fh);
}

# A method that helps covert a binary input file to hexadecimal values
sub bin_file_to_hex_file {
    my $input = shift;
    my $output = shift;

    open(my $fh, '<', $input) or die "Cannot Open Input File: $!";
    open(my $fh2, '>', $output) or die "Cannot Open Output File: $!";

    while (my $line = <$fh>) {
        my @array = split /\s/, $line; # split on all whitespace, thats the reg expr for that
        for my $i (0..$#array) {
            my $x_num = oct("0b" . $array[$i]);
            print $fh2 "0x";
            print $fh2 sprintf('%X', $x_num);
            if ($i == $#array) {
                print $fh2 "\n";
            } else {
                print $fh2 " ";
            }
        }
    }   

    close($fh2);
    close($fh);
}

# A method that combines the above functions and writes to both files at the same time
# better complexity
sub bin_file_to_dec_hex_file {
    my $input = shift;
    my $output_dec = shift;
    my $output_hex = shift;

    open(my $fh, '<', $input) or die "Cannot Open Input File: $!";
    open(my $fh2, '>', $output_dec) or die "Cannot Open Output decimal File: $!";
    open(my $fh3, '>', $output_hex) or die "Cannot Open Output hex File: $!";

    while (my $line = <$fh>) {
        my @array = split /\s/, $line; # split on all whitespace, thats the reg expr for that
        for my $i (0..$#array) {
            my $x_num = oct("0b" . $array[$i]);
            print $fh3 "0x";
            print $fh3 sprintf('%X', $x_num);
            if ($x_num <= 9) {
                print $fh2 "0";
            }
            print $fh2 $x_num;
            if ($i == $#array) {
                print $fh2 "\n";
                print $fh3 "\n";
            } else {
                print $fh2 " ";
                print $fh3 " ";
            } 
        }
    }

    close($fh3);
    close($fh2);
    close($fh);
}

rand_bin_file("test_file.txt", 100, 8);
bin_file_to_dec_file("test_file.txt", "out_dec.txt");
bin_file_to_hex_file("test_file.txt", "out_hex.txt");
bin_file_to_dec_hex_file("test_file.txt", "out_dec2.txt", "out_hex2.txt"); # better runtime