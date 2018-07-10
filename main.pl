#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my $filename = $ARGV[0];
my $ref_filename = \$filename;

openfcsv($ref_filename);
#Open file
sub openfcsv{
    my $reffile = shift;
    open(my $fh, '<', ${$reffile}) or die "data: $!\n";
    
    my $reffh = \*$fh; ##reference a glob

    my $test = convertfcsv($reffh);

    open(my $out, '>', 'world-cities-sorted.txt') or die $!;

    if(-e $out){

        print $out Dumper($test);
        print("Knowledge base already exists...\n");
        findMe($test);
    }
    else{
        print $out Dumper($test);
        findMe($test);
    }
}

sub findMe(){
    my $hash = shift;

    my @Country = ();
    my @SCountry = ();
    my @City = ();

    while(my($k1, $ref1) = each %{$hash}){
        while(my($k2, $ref2) = each $hash->{$k1}){
            #while(my($k3, $ref3) = each $hash->{$k1}->{$k2}){
             #   push(@City, $k3);
            #}
            push(@Country, $k2);
    
        }
        push(@SCountry, $k1);
            
    }



    my $regexC = "";
    $regexC .= join "|", @Country;
    
    my $regexSC = "";
    $regexSC .= join "|", @SCountry;
    
    my $regexCt = "";
    $regexCt .= join "|", @City;
    
    print("Knowledge base loaded...\n");
    
    print("Entry Query: ");

    my $q = <STDIN>;
    
    if(grep {/where/i} $q){
        my $d = "";
            if($q =~ /(\w$regexSC\w)/i){
                $d = $1;
                $d = join " ", map{ucfirst} split " ", $d;
                print("\n$d is located in ");
                print(keys $hash->{$d});
                print("\n");
            }else{
                print("\n $d not found.\n");

            }
    }
    else{
        print("\n\'Where\' questions are only accepted.\n");
    }
    

}

sub convertfcsv{
    my $reffh = shift;
    my %GLOBE;
    while(my $row = <$reffh>){
        chomp $row;
        my @arr = split(",", $row);
        $GLOBE{$arr[2]}{$arr[1]}= $arr[0]; ##Country, Sub-Country, City, Geocode;
    }
    print("Knowledge base created...\n");
    return \%GLOBE;
}

