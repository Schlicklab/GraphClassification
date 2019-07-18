#!/usr/local/bin/perl

%existing=();
open(FILE,"<$ARGV[0]");
while($line=<FILE>){

	@cols=split(/\s+/,$line);
	$existing{$cols[0]}=1;
}
close(FILE);

@non_existing=();
open(FILE,"<$ARGV[1]");
while($line=<FILE>){

	$line=~ s/\n//g;
	@cols=split(/\s+/,$line);
	if(exists $existing{$cols[0]}){

		next;
	}
	else{

		push @non_existing,$line;
	}
}
close(FILE);

$num_exist = keys %existing;
$num_hpo = scalar @non_existing;

%random_nums=();
$count=0;
while($count < $num_exist){

	$num=int(rand($num_hpo));
	if(exists $random_nums{$num}){

		next;
	}
	else{
	
		$random_nums{$num}=1;
		$count++;
	}
}

foreach $key (keys %random_nums){

	print $non_existing[$key]."\t2\n";
}
