#!/usr/bin/perl

use List::MoreUtils qw/ uniq /;
use Sort::Fields;
use Term::ANSIColor;
use Getopt::Std;
use PerlIO::gzip;
use File::ReadBackwards;

my %options=();
getopts("he", \%options);

if ($options{h})
{
 do_help();
}

sub do_help {
	print "\nMailStats.pl - By Chris Ice\n\n";
	print "Run with no flags to parse /var/log/exim_mainlog\n\n";
	print "Usage: \n\n";
	print "-h : Show this help text\n";
	print "-e : Check extended logs - Does not check /var/log/exim_mainlog, just the gzipped files\n";
	print "\n\n\n";
	die "\n";
}

if ($options{e}) {
my @files = </var/log/exim_mainlog*.gz>;
foreach (@files) {
open FILE, "<:gzip", $_ or die $!;
}
}
else {
open FILE, "/var/log/exim_mainlog";
}

## section for system users

print color 'red';
print "\nEmails by user: " . color 'reset';
print "\n\n";
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

print "\n\n";
print colored ['red on_blue'], "Total:  " . scalar (@system_users - 1);
print "\n";

## Section for email accounts

print color 'red';
print "\nEmail accounts sending out mail:\n\n";
print color 'reset';
if ($options{e}) {
my @files = </var/log/exim_mainlog*.gz>;
foreach (@files) {
open FILE, "<:gzip", $_ or die $!;
}
}
else {
open FILE, "/var/log/exim_mainlog";
}
@email_users = "";

while ( $lines_email = <FILE>) {
if ( $lines_email=~/(_login:|_plain:)(.+?)(\sS=)/i) {
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
if ($options{e}) {
my @files = </var/log/exim_mainlog*.gz>;
foreach (@files) {
open FILE, "<:gzip", $_ or die $!;
}
}
else {
open FILE, "/var/log/exim_mainlog";
}
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
print "\nTop 50 Email Titles:\n\n\n";
print color 'reset';
if ($options{e}) {
my @files = </var/log/exim_mainlog*.gz>;
foreach (@files) {
open FILE, "<:gzip", $_ or die $!;
}
}
else {
open FILE, "/var/log/exim_mainlog";
}
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

my $limit = 50;
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

if (!$options{e}) {
open (my $file, "/var/log/exim_mainlog") or die "Couldn't open file : $!";
my $first = <$file>;
close $file;
if ( $first =~ /(^.+?\:[0-9][0-9])\s/i ) {
$foutput =  $1;
print "Log dates and times are: \n\nStart : " . $foutput;
}
my $last = File::ReadBackwards->new("/var/log/exim_mainlog")->readline;
if ( $last =~ /(^.+?\:[0-9][0-9])\s/i ) {
$lastoutput = $1;
print "\nEnd : " . $lastoutput;
print "\n\n";
}
}
