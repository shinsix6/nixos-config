{ config, pkgs, inputs, lib, ...}:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
    '';

    # Set alias
    shellAliases = {
      la = "ls -a";
      ll = "ls -l";
      snvim = "sudo nvim";
      svim = "sudo vim";
      nx = "cd ~/nixos-config/"; # cd to nixos conf folder
      nixre = "sudo nixos-rebuild switch --flake ~/nixos-config#shinsix6";
      neru = "systemctl suspend";
      nixconf = "nvim ~/nixos-config/configuration.nix";
      hmconf = "nvim ~/nixos-config/home/home.nix";
      flakeconf = "nvim ~/nixos-config/flake.nix";
      hmre = "home-manager switch --flake ~/nixos-config#shinsix6";
      update-nh = "nh os switch -u ~/nixos-config#shinsix6"; # update flake and rebuild
      sys-nh = "nh os switch ~/nixos-config#shinsix6"; # rebuild os
      hm-nh = "nh home switch ~/nixos-config"; # rebuild home-manager
      winmount = "sudo mount -t ntfs /dev/nvme0n1p3 /mnt/windows/"; # mount windows
      slixxmount = "sudo mount -t ntfs /dev/nvme0n1p7 /mnt/slixx"; # mount slixx disk
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      format = ''$username$directory$git_branch$git_status$character'';

      add_newline = false;
      
      # individual configuration 
      username = {
        show_always = true;
        format = "[$user](bold green) on ";
      };

      directory = {
        style = "bold white";
        truncation_length = 3;
      };

      git_branch = {
        symbol = " ";
        format = "via [$symbol$branch]($style) ";
        style = "bold purple";
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
        style = "bold green";
      };

      character = {
        success_symbol = "\n[➜](bold blue)";
        error_symbol = "\n[➜](bold green)";
      };
    };
  };
}
