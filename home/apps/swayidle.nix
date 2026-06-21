{ pkgs, config, ... }:

{
  services.swayidle = 
  let
    # lock command
    lock = "${pkgs.swaylock}/bin/swaylock --daemonize";

    # niri
    display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
  in
  {
    enable = false;
    timeouts = [
  
      {
        timeout = 600;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
      }
      {
        timeout = 660;
        command = lock;
      }
      {
        timeout = 670;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 700;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = (display "off") + "; " + lock;
      }
      {
        event = "after-resume";
        command = display "on";
      }
      {
        event = "lock";
        command = (display "off") + "; " + lock;
      }
      {
	event = "unlock";
	command = display "on";
      }
    ];
  };
}
