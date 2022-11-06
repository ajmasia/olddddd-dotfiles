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

  picom = {
    enable = true;

    fade = true;
    fadeSteps = [ "0.03" "0.28" ];
    fadeDelta = 8;

    inactiveOpacity = "0.92";
    opacityRule = [ "100:class_g = 'Rofi'" ];

    experimentalBackends = true;
    vSync = true;
    backend = "glx";

    noDNDShadow = false;
    noDockShadow = false;
    menuOpacity = "1.0";

    extraOptions = ''
      frame-opacity = 0.85;
      inactive-opacity-override = false;

      mark-wmwin-focused = true;
      mark-ovredir-focused = false

      corner-radius = 12
      rounded-corners-exclude = [
        "window_type = 'dock'",
      ];

      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;

      log-level = "warn";

      wintypes:
      {
        tooltip = { fade = true; shadow = false; opacity = 1.0; focus = true; full-shadow = false; };
        dock = { clip-shadow-above = true; }
        popup_menu = { shadow = false }
        dropdown_menu = { shadow = false; }
      };
    '';
    
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

  udiskie = {
    enable = true;
    notify = true;
  };


  grobi = {
    enable = true;
    rules =
      let
        LAPTOP_SCREEN = "eDP-1";
        HOME_SCREEN = "HDMI-1";
      in
      [
        {
          name = "Laptop";
          outputs_disconnected = [ HOME_SCREEN ];
          outputs_connected = [ LAPTOP_SCREEN ];
          configure_single = LAPTOP_SCREEN;
          primary = LAPTOP_SCREEN;
          atomic = true;
          execute_after = [
            "bspc wm -r"
          ];
        }
        {
          name = "Laptop + External";
          outputs_connected = [ LAPTOP_SCREEN HOME_SCREEN ];
          configure_row = [ LAPTOP_SCREEN HOME_SCREEN ];
          primary = HOME_SCREEN;
          atomic = true;
          execute_after = [
            "bspc wm -r"
          ];
        }
      ];
  };
}
