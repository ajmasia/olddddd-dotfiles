{ ... }:
{
  blueman-applet = {
    enable = true;
  };

  clipmenu = {
    enable = true;
  };

  flameshot = {
    enable = true;
  };

  network-manager-applet = {
    enable = true;
  };

  dunst = {
    enable = true;
    settings = import ./services/dunst;
  };

  sxhkd = {
    enable = true;
    keybindings = import ./services/sxhkd/keybindings.nix;
  };

  xscreensaver = {
    enable = true;
  };

  redshift = {
    enable = true;
    #provider = "geoclue2";

    settings = {
      redshift.brightness-day = 1;
      redshift.brightness-night = 0.8;
    };

    latitude = "36";
    longitude = "-6";

    temperature = {
      day = 7700;
      night = 3700;
    };

    tray = true;
  };

  grobi = {
    enable = true;
    rules =
      let
        LAPTOP_SCREEN = "eDP";
        HOME_SCREEN = "HDMI-A-0";
      in
      [
        {
          name = "Solo";
          outputs_connected = [ LAPTOP_SCREEN ];
          outputs_disconnected = [ HOME_SCREEN ];
          configure_single = LAPTOP_SCREEN + "@1920x1080";
          primary = true;
          atomic = true;
          execute_after = [ ];
        }
        {
          name = "Office";
          outputs_connected = [ LAPTOP_SCREEN HOME_SCREEN ];
          configure_row = [ LAPTOP_SCREEN HOME_SCREEN ];
          primary = HOME_SCREEN;
          atomic = true;
          execute_after = [ ];
        }
      ];
  };
}
