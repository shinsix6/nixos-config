{ config, pkgs, ... }:

{
  services.stirling-pdf = {
    enable = true;
  };

  systemd.services.stirling-pdf.path = [ pkgs.libreoffice ];
}
