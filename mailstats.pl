#!/usr/bin/perl

use List::MoreUtils qw/ uniq /;

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
	if ($key eq "" ) {
		delete($count{$key});
}
}

while (my ($key, $value) = each(%count)) {
	print "$key:$value\n";
}

print "\n";
print "\nTotal:  " . scalar @system_users . "\n";

print "\nEmail accounts sending out mail:\n\n";

open FILE, ("/var/log/exim_mainlog");
@email_users = "";

while ( $lines_email = <FILE>) {
if ( $lines_email=~/(_login:)(.+?)(.S=)/i) {
my $lines_emails = $2;
push (@email_users, $lines_emails);
}
}
my %email_count;
$email_count{$_}++ foreach @email_users;
while (my ($key, $value) = each(%email_count)) {
	if ($key eq "") {
		delete($email_count{$key});
}
}

while (my ($key, $value) = each(%email_count)) {
	print "$key:$value\n\n";
}

print "\n";
print "Total: " . scalar @email_users . "\n";


print "\nEmail Titles:\n\n\n";

@titles = "";

open FILE, "/var/log/exim_mainlog";

while ($titles = <FILE>) {
if ( $titles=~/(T=\")(.+?)(\")/i) {
my $title = $2;
push (@titles, $title)
}
}
my %titlecount;
$titlecount{$_}++ foreach @titles;
while (my ($key, $value) = each(%titlecount)) {
	if ($key eq "" ) {
		delete($titlecount[$key]);
}
}

while (my ($key, $value) = each(%titlecount)) {
	print "$key:$value\n";
}
print "\n\nTotal: " . scalar @titles . "\n";
