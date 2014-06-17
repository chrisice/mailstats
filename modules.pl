#!/usr/bin/perl

my $module1 = '/usr/local/share/perl5/Sort/Fields.pm';
if (-e $module1){
print "\n\nSort::Fields module already installed.  Continuing\n\n";
}
else{
print "\n\nSort::Fields module not installed.  Would you like to install it now?  (y/n) ";
$yn = <STDIN>;
	if ($yn =~ /y/){
        system("/scripts/perlinstaller Sort::Fields");
}
        elsif ($yn =~ /n/) {
        die "\n\nScript cannot run without the required modules.  Stopping\n";
}
        elsif ( ($yn =~ /y/) && ($yn =~ /n/) ){

        die "\n\nMust choose y or n.  Stopping\n\n";
}
}

my $module2 = '/usr/local/lib64/perl5/List/MoreUtils.pm';
if (-e $module2){
print "\n\n\nList::MoreUtils module already installed.  Continuing\n\n";
}
else{
print "\n\nList::MoreUtils module not installed.  Would you like to install it now?  (y/n) ";
$yn2 = <STDIN>;
        if ($yn2 =~ /y/){
        system("/scripts/perlinstaller List::MoreUtils");
}
        elsif ($yn2 =~ /n/) {
        die "\n\nScript cannot run without the required modules.  Stopping\n\n";
}
        elsif ( ($yn2 =~ /y/) && ($yn2 =~ /n/) ){
        die "\n\nMust choose y or n.  Stopping\n\n";
}
}

my $module3 = '/usr/local/lib64/perl5/PerlIO/gzip.pm';
if (-e $module3){
print "\n\n\nPerlIO::gzip module already installed.  Continuing\n\n";
}
else{
print "\n\n\nPerlIO::gzip module not installed.  Would you like to install it now?  (y/n)";
$yn3 = <STDIN>;
        if ($yn3 =~ /y/){
        system("/scripts/perlinstaller PerlIO::gzip");
}
        elsif ($yn3 =~ /n/) {
        die "\n\nScript cannot run without the required modules.  Stopping\n\n";
}
        elsif ( ($yn3 =~ /y/) && ($yn3 =~ /n/) ){
        die "\n\nMust choose y or n.  Stopping\n\n";
}
}

my $module4 = '/usr/local/share/perl5/File/ReadBackwards.pm';
if (-e $module4){
print "\n\n\nFile::ReadBackwards module already installed.  Continuing\n\n";
}
else{
print "\n\n\nFile::ReadBackwards module not installed.  Would you like to install it now?  (y/n)";
$yn4 = <STDIN>;
        if ($yn4 =~ /y/){
        system("/scripts/perlinstaller File::ReadBackwards");
}
        elsif ($yn4 =~ /n/) {
        die "\n\nScript cannot run without the required modules.  Stopping\n\n";
}
        elsif ( ($yn4 =~ /y/) && ($yn4 =~ /n/) ){
        die "\n\nMust choose y or n.  Stopping\n\n";
}
}

print "\n\n\nFishing installing modules.  Running script\n\n\n";

system('curl -s https://raw.githubusercontent.com/chrisice/mailstats/master/mailstats.pl | perl');
