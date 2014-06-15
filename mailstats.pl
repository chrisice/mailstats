#!/usr/bin/perl

use List::MoreUtils qw/ uniq /;
use Sort::Fields;
use Term::ANSIColor;

open FILE, "/var/log/exim_mainlog";

## section for system users

print color 'red';
print "\nEmails by user:\n\n";
print color 'reset';
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

foreach my $value (reverse sort { $count{$a} <=> $count{$b} }  keys %count) {
print " " . $count{$value} . " : " . $value . "\n";
}

print "\n";
print colored ['red on_blue'], "\nTotal:  " . scalar (@system_users - 1);
print "\n";

## Section for email accounts

print color 'red';
print "\nEmail accounts sending out mail:\n\n";
print color 'reset';
open FILE, "/var/log/exim_mainlog";

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

foreach my $value (reverse sort { $email_count{$a} <=> $email_count{$b} }  keys %email_count) {
print " " . $email_count{$value} . " : " . $value . "\n";
}

print "\n";
print colored ['red on_blue'], "Total: " . scalar (@email_users - 1);
print "\n";

## Section for current working directories

print color 'red';
print "\nCurrent working directories:\n\n\n";
print color 'reset';
open FILE, "/var/log/exim_mainlog";
@dirs = "";


while ($dirs = <FILE>) {
if ( $dirs=~/(cwd=)(.+?)(\s)/i) {
my $dir = $2;
push (@dirs, $dir);
}
}
my %dirs;
$dirs{$_}++ foreach @dirs;
while (my ($key, $value) = each(%dirs)) {
        if ($key =~ /^$/ ) {
                delete($dirs[$key]);
}
}
 
while (my ($key, $value) = each(%dirs)) {
        if ($key =~ /^$/) {
                delete($dirs{$key});
}
}

foreach my $value (reverse sort { $dirs{$a} <=> $dirs{$b} }  keys %dirs) {
print " " . $dirs{$value} . " : " . $value . "\n";
}

print "\n";
print colored ['red on_blue'], "Total: " . scalar (@dirs - 1);
print "\n";

## Section for titles 

print color 'red';
print "\nTop 20 Email Titles:\n\n\n";
print color 'reset';
open FILE, "/var/log/exim_mainlog";

@titles = "";


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

my $limit = 20;
my $loops = 0; 
foreach my $value (reverse sort { $titlecount{$a} <=> $titlecount{$b} }  keys %titlecount) {
print " " . $titlecount{$value} . " : " . $value . "\n";
$loops++;
if ($loops >= $limit) {
	last;
}
}
print "\n\n";
print colored ['red on_blue'], "Total: " . scalar (@titles - 1);
print "\n\n";
close FILE;
