#!/usr/bin/perl
# takes the csv filename as an argument and replaces 0's not in the TARGET column with the mean average of that column
# use like:  perl file_parser train.csv > newtrain.csv
# I took the subroutine from perlmonks.org/?node_id=904526

sub rotate {
	my @src = @_;
	my $max_col = 0;
	$max_col < $#$_ and $max_col = $#$_ for @src;
	my @dest;
	for my $col (0..$max_col){
		push @dest, [map {$src[$_][$col] // ''} (0..$#src)]
	}
	return @dest;
}



open(INFILE, '<', $ARGV[0]);
my $string;
while(my $line = <INFILE>){
	chomp $line;	
	my $counter = 0;
	foreach(split(',', $line)){	
		push(@{$matrix[$counter]}, $_);
		$counter++;
	}
}

foreach $i(0..$#matrix -1){
	$total = 0;
	$number = 0;
	foreach $j(0..$#{$matrix[$i]}) {
		if($matrix[$i][$j]){
			$total += $matrix[$i][$j];
			$number ++;
		}
	}
	$average_of_column{$i} = $total / $number;
}

foreach $i(0..$#matrix - 1){
	foreach $j(0..$#{$matrix[$i]}){
		if(! $matrix[$i][$j]){
			$matrix[$i][$j] = $average_of_column{$i};
		}
	}
}
print join "\n", map { $_ = join ",", @{$_} } rotate(@matrix);
