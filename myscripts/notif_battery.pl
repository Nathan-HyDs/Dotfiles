use strict;
use warnings;

# CONST for percentage
my $CMD_GET_BATTERY_CARAC = "upower -i /org/freedesktop/UPower/devices/battery_BAT0";
my $CARAC_TEXT = "percentage:" ;


# CONST for notification
my $CMD_NOTIFICATION = "notify-send";
my $CMD_NOTIFICATION_FLAG = "-u";

# CONST for limit before send notify
my $LIMIT_INFO=15;
my $LIMIT_WARN_1=10;
my $LIMIT_WARN_2=5;

# CONST for loop (seconds)
my $TIME_WAIT = 30;

# Function to get battery pourcetage
sub getPercetageBattery(){
  # shell function to get battery caracteristics
  my $result=`$CMD_GET_BATTERY_CARAC`;

  # split lines per \n
  my @lines = split "\n", $result ;

  # loop for find line with percentage
  my $line;
  foreach $line (@lines){
    if($line =~ /percentage:.*/){
      # grep extract percentage to $1
      $line =~ /([0-9]{1,2})/;
      return $1;
    }
  }
}

# send notification with good format ($type : 1=>INFO, 2=>WARN1, 3=>WARN2)
sub notify_send{
  my ($type) = @_;
  my $notification_level='';
  my $title = "Battery info...";
  my $body='<ERROR>';
  if($type==1) {
      $notification_level='low';
      $body='Warning battery percentage under 15%';
    }
    if($type==2) {
      $notification_level='critical';
      $body='Warning battery percentage under 10%';
    }
    if($type==3) {
      $notification_level='critical';
      $body='Warning battery percentage under 5%';
    }
  system("$CMD_NOTIFICATION $CMD_NOTIFICATION_FLAG $notification_level '$title' '$body'");
  return 1;
}

# BOOL
my $inf_INFO_send=0;
my $inf_WARN1_send=0;
my $inf_WARN2_send=0;

while (1) {
  my $data = getPercetageBattery();
  if($data<=$LIMIT_INFO && !$inf_INFO_send){
      $inf_INFO_send=1;
      notify_send(1);
  }
  elsif($data<=$LIMIT_WARN_1 && !$inf_WARN1_send){
      $inf_WARN1_send=1;
      notify_send(2);
  }
  elsif($data<=$LIMIT_WARN_2 && !$inf_WARN2_send){
      $inf_WARN2_send=1;
      notify_send(3);
  }
  elsif($data>$LIMIT_INFO && $inf_INFO_send){
    $inf_INFO_send=0;
    $inf_WARN1_send=0;
    $inf_WARN2_send=0;
  }
  sleep($TIME_WAIT);
}
