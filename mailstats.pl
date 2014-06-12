#!/usr/bin/perl

use List::MoreUtils qw/ uniq /;
use Sort::Fields;


open FILE, "/var/log/exim_mainlog";

#section for system users

print "\nEmails by user:\n\n";
our @system_users = "";

while ( $lines_users = <FILE> ){
if ( $lines_users=~/(U\=)(.+?)(\sP\=)/i ) {
my $line_users = $2;
push (@system_users, $line_users)
}
}
my %count;
$count{$_}++ foreach @system_users;
while (my ($key, $value) = each(%count)) {
	if ($key =~ /^$/ ) {
		delete($count{$key});
}
}

#while (my ($key, $value) = each(%count)) {
#	print "$key:$value\n";

foreach my $value (reverse sort { $count{$a} <=> $count{$b} }  keys %count) {
print " " . $count{$value} . " : " . $value . "\n";
}

print "\n";
print "\nTotal:  " . scalar (@system_users - 1) . "\n";

print "\nEmail accounts sending out mail:\n\n";

open FILE, ("/var/log/exim_mainlog");
@email_users = "";

while ( $lines_email = <FILE>) {
if ( $lines_email=~/(_login:)(.+?)(\sS=)/i) {
my $lines_emails = $2;
push (@email_users, $lines_emails);
}
}
my %email_count;
$email_count{$_}++ foreach @email_users;
while (my ($key, $value) = each(%email_count)) {
	if ($key =~ /^$/) {
		delete($email_count{$key});
}
}

#while (my ($key, $value) = each(%email_count)) {
#	print "$key:$value\n\n";

foreach my $value (reverse sort { $email_count{$a} <=> $email_count{$b} }  keys %email_count) {
print " " . $email_count{$value} . " : " . $value . "\n";
}



print "\n";
print "Total: " . scalar (@email_users - 1). "\n";


print "\nEmail Titles:\n\n\n";

@titles = "";

open FILE, "/var/log/exim_mainlog";

while ($titles = <FILE>) {
if ( $titles=~/((U=|_login:).+)((?<=T=\").+?(?=\"))(.+$)/i) {
my $title = $3;
push (@titles, $title);
}


}
my %titlecount;
$titlecount{$_}++ foreach @titles;
while (my ($key, $value) = each(%titlecount)) {
	if ($key =~ /^$/ ) {
		delete($titlecount[$key]);
}
}



#while (my ($key, $value)  = each (%titlecount)) {
#	print sort "$value : $key\n";
#
my $limit = 20;
my $loops = 0; 
foreach my $value (reverse sort { $titlecount{$a} <=> $titlecount{$b} }  keys %titlecount) {
print " " . $titlecount{$value} . " : " . $value . "\n";
$loops++;
if ($loops >= $limit) {
	last;
}
}
print "\n\nTotal: " . scalar (@titles - 1) . "\n";

close FILE;
