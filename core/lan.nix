{ config, pkgs, ... }:

{
  # Disable Energy-Efficient Ethernet on boot
  systemd.services.disable-eee = {
    description = "Disable Energy Efficient Ethernet on Realtek NIC";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    wants = [ "network-online.target" ];
    path = [ pkgs.ethtool ];
    script = ''
      ethtool --set-eee enp44s0 eee off || true
    '';
  };
}
