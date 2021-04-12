# AWS_helpers
Useful scripts and config files for AWS

RenewMacAddress.sh:
This script automatically renews your local MAC address in your AWS security group to allow connecting to your VM's via ssh.

post_install_script_tecplot.txt:
This script gives an example for a post installation instance, when starting an AWS EC2 instance. You can call such a script with the option --user-data file://YOUR_SCRIPT.txt
This example installs firefox and gedit and copies a Tecplot 360 installation from your S3 bucket to the new machine.
