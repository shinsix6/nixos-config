{ config, pkgs, ... }:

{
  services.tlp = {
      enable = true;
      settings = {
	  CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
	  CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";

	  # Battery performance
	  CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
	  CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
	  CPU_BOOST_ON_BAT = 1;
	  CPU_MAX_PERF_ON_BAT = 95;

	  # NVME deep sleep 0 or 1
	  NVME_APST_ON_BAT = 0;

	  # Ideapad Battery Protection
	  START_CHARGE_THRESH_BAT1 = 0;
	  STOP_CHARGE_THRESH_BAT1 = 1;

	  PLATFORM_PROFILE_ON_BAT = "low-power";
	  PLATFORM_PROFILE_ON_AC = "low-power";
      };
  };
}
