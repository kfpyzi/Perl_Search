
use strict;
use warnings;


my @array = ("Antipolo", "San Isidro");

my $n = "Kyle";
my @age = (2,0);
my %loca = ( brgy => "San Isidro",);

my $nref = \$n;
my $aref = \@age;
my $lref = \%loca;

my @hrray = ($nref, $aref, $lref);
my %hash = (
    name => "Kyle",
    age => "20",
    loc => \@array,
    all => \@hrray,
);

my $href = \%hash;

man($href);

sub man{
    my $p = shift;
    my $name = $p->{name};
    my $age = $p -> {age};
    my @location = @{$p->{loc}};

    print("My name is ".$name." I am ".$age." years old. ");
    print("I live in ");
    print(@location);
    print(".\n");

    my @has = @{$p->{all}};
    
    foreach my $kind (@has){
        if(ref $kind eq 'HASH'){
            print(%{$kind}->{brgy}." ");
        }
        elsif(ref $kind eq 'SCALAR'){
            print(${$kind}." ");
        }
        elsif(ref $kind eq 'ARRAY'){
            print(@{$kind});
        }
        else{
            print("None");
        }
    }
    print("\n");
}