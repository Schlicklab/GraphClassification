#!/usr/local/bin/perl

%all_topos=();
$rnalike=0;
$nonrnalike=0;
$total=0;
open(FILE,"$ARGV[0]");
while($line=<FILE>){

	$line =~ s/\n//g;
	@cols=split(/\s+/,$line);
	$all_topos{$cols[0]}=$cols[1];
	$total++;
	if($cols[1] == 1){
		$rnalike++;
	}
	else{
		$nonrnalike++;
	}
}
close(FILE);

print "RNA-like: ".$rnalike."\n";
print "Non RNA-like: ".$nonrnalike."\n";
print "Total: ".$total."\n";

open(LIST,"<$ARGV[1]");
$rnalike=0;
$nonrnalike=0;
$non_class=0;
$total=0;
while($topo=<LIST>){

	$topo =~ s/\n//g;
	$total++;
	if(exists $all_topos{$topo}){

		if($all_topos{$topo} == 1){
			$rnalike++;
		}
		else{
			$nonrnalike++;
			print "Misclassified: ".$topo."\n";
		}
	}
	else{

		$non_class++;
		print "This topology was not classified ".$topo."\n";
	}	
}
close(LIST);

print "RNA-like: ".$rnalike."\n";
print "Non RNA-like: ".$nonrnalike."\n";
print "Not classified: ".$non_class."\n";
print "Total: ".$total."\n";
