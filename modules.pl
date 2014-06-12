#!/usr/bin/perl

my $module1 = '/usr/local/share/perl5/Sort/Fields.pm';
if (-e $module1){
print "\n\nSort::Fields module already installed.  Continuing\n\n";
}
else{
print "Sort::Fields module not installed.  Would you like to install it now?  (y/n) ";
$yn = <STDIN>;
	if ($yn =~ /y/){
        system("/scripts/perlinstaller Sort::Fields");
}
        elsif ($yn =~ /n/) {
        die "Script cannot run without the required modules.  Stopping\n";
}
        elsif ( ($yn =~ /y/) && ($yn =~ /n/) ){

        die "Must choose y or n.  Stopping";
}
}

my $module2 = '/usr/local/lib64/perl5/List/MoreUtils.pm';
if (-e $module2){
print "\n\n\nList::MoreUtils module already installed.  Continuing\n\n";
}
else{
print "List::MoreUtils module not installed.  Would you like to install it now?  (y/n) ";
$yn2 = <STDIN>;
        if ($yn2 =~ /y/){
        system("/scripts/perlinstaller List::MoreUtils");
}
        elsif ($yn2 =~ /n/) {
        die "Script cannot run without the required modules.  Stopping";
}
        elsif ( ($yn2 =~ /y/) && ($yn2 =~ /n/) ){
        die "Must choose y or n.  Stopping";
}
}
print "\n\n\nFishing installing modules.  Running script\n\n\n";

system('curl -s https://raw.githubusercontent.com/chrisice/mailstats/master/mailstats.pl | perl');
