#!/usr/bin/perl
use strict;
use warnings;

# CONST for volume commands
my $CMD_GET_VOLUME_PERCENTAGE = "pactl list sinks | grep '^[[:space:]]Volume:'";
my $CMD_UP_SOUND="pactl set-sink-volume 0 +";
my $CMD_DOWN_SOUND="pactl set-sink-volume 0 -";
my $CMD_SET_SOUND="pactl set-sink-volume 0 ";

# CONST for notification
my $CMD_NOTIFICATION = "notify-send";
my $CMD_NOTIFICATION_FLAG = "-u low -t 100";

#Test number of argument
if(($#ARGV)!=1){
  print "\nUsage: volume_set.pl <down/up/set> <percentage>\n";
  exit(1);
}

if($ARGV[1] =~ /^[0-9]*$/){
  if($ARGV[0] eq "down"){
    system($CMD_DOWN_SOUND.$ARGV[1]."%");
  }elsif($ARGV[0] eq "up"){
    system($CMD_UP_SOUND.$ARGV[1]."%");
  }elsif($ARGV[0] eq "set"){
    system($CMD_SET_SOUND.$ARGV[1]."%");
  }else{
    print "\nUsage: volume_set.pl <down/up/set> <percentage>\n";
    exit(3);
  }
}else{
  print "\nUsage: percentage need to be a number\n";
  exit(2);
}

my $line_info = `$CMD_GET_VOLUME_PERCENTAGE`;
$line_info =~ /([0-9]{1,3})%/;
my $volume = $1;
system("$CMD_NOTIFICATION $CMD_NOTIFICATION_FLAG VOLUME $volume%");
exit(0);
