{ config, pkgs, ... }:

{
  # 1. Install the out-of-tree Acer WMI battery kernel module
  boot.extraModulePackages = with config.boot.kernelPackages; [
    acer-wmi-battery
  ];

  # 2. Load the module automatically at boot
  boot.kernelModules = [ "acer-wmi-battery" ];

  # 3. Force the 80% cap by writing '1' to the newly exposed health_mode node
  systemd.tmpfiles.rules = [
    "w /sys/bus/wmi/drivers/acer-wmi-battery/health_mode - - - - 1"
  ];
}
