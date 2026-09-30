{ pkgs, config, ...}:

{
  services.mako = {
    enable = true;
    settings = {
      background-color = "#002147";
      text-color = "#bcd4e6";
      width = 250;
      height = 100;
      padding = 4;
      border-size = 2;
      border-color = "#cacaca";
      default-timeout = 7000;
    };
  };
}
