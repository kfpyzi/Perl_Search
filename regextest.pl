use strict;
use warnings;

my $sca = "Berlin|Germany|Test";
my @scr = ('Berlin men', 'Germany', 'Test');

my $q = "where is in the map berlin";
print($sca."\n");
print(ucfirst($1)."\n") if($q =~ /($sca)/i);