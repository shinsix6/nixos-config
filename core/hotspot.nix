{ config, pkgs, ... }:

{
    networking.networkmanager.unmanaged = [ "wlan0" ];

    services.create_ap = {
      enable = true;
      settings = {
        INTERNET_IFACE = "enp44s0";
        WIFI_IFACE = "wlan0";
        SSID = "666SATAN";
        PASSPHRASE = "thedevilini";
        # FREQ_BAND = "5";
        CHANNEL = "149";
        # ISO_COUNTRY_CODE = "ID";
      };
    };

    # Automatically unblock Wi-Fi radio before create_ap starts
    systemd.services.create_ap.preStart = "${pkgs.util-linux}/bin/rfkill unblock wifi";
}
