Mailstats.pl
=========

Gives a report of recently sent email.  Shows system users, email users and email titles.

Usage:  

perl <(curl -s https://raw.githubusercontent.com/chrisice/mailstats/master/mailstats.pl)
perl <(curl -s https://raw.githubusercontent.com/chrisice/mailstats/master/mailstats.pl) -h  :   View help text
perl <(curl -s https://raw.githubusercontent.com/chrisice/mailstats/master/mailstats.pl) -e  :   To view extended logs only (/var/log/exim_mainlog*.gz)

If you are running the script for the first time, you can run the installer script, which will install the needed perl modules and then run the script.  That can be run using this command.  


perl <(curl -s https://raw.githubusercontent.com/chrisice/mailstats/master/modules.pl)
