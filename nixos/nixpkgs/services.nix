{ pkgs, ... }:

with pkgs; {
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

  pasystray = {
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

    package = picom-jonaburg;

    vSync = true;
    backend = "glx";
    experimentalBackends = true;

    shadow = false;
    shadowExclude = [];

    activeOpacity = 1.0;
    inactiveOpacity = 0.88;
    opacityRules = [
      "100:class_g = 'Rofi'"
      "100:window_type = 'notification'"
    ];

    fade = true;
    fadeSteps = [ 0.03 0.03 ];
    fadeDelta = 8;
    fadeExclude = [ ];

    wintypes = import ./services/picom/wintypes.nix;
    settings = import ./services/picom/settings.nix;
  };

  stalonetray = {
    enable = false;

    config = {
      transparent = true;
      geometry = "6x1-0+0";

      background = " #000000";
      icon_size = 22;
      kludges = "force_icons_size";
      grow_gravity = "E";
    };
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
    tray = "auto";

    settings = {
      program_options = {
        udisks_version = 2;
      };

      icon_names = {
        media = [ "drive-removable-media" ];
        eject = [ "media-eject" ];
        unmount = [ "drive-optical" ];
        detach = [ "system-shutdown-symbolic" ];
        losetup = [ "drive-removable-media" ];
        mount = [ "drive-removable-media" ];

      };
    };
  };


  grobi = {
    enable = false;
    executeAfter = [
      "notify-send 'Grobi'"
    ];
    rules =
      let
        LAPTOP_SCREEN = "eDP";
        HOME_SCREEN = "HDMI-A-0";
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
            "notify-send 'Laptop'"
          ];
        }
        {
          name = "Laptop + External";
          outputs_connected = [ LAPTOP_SCREEN HOME_SCREEN ];
          configure_row = [ LAPTOP_SCREEN HOME_SCREEN ];
          primary = HOME_SCREEN;
          atomic = true;
          execute_after = [
            "notify-send 'Laptop + External'"
          ];
        }
      ];
  };

  polybar = import
    ./services/polybar
    { pkgs = pkgs; };

  trayer = {
    enable = false;

    settings = {
      monitor = "primary";
      widthtype = "request";

      distancefrom = "top";
      distance = 17;
      align = "right";
      edge = "top";
      iconspacing = 4;

      margin = 430;

      transparent = true;
      alpha = 0;
      tint = "0x282c34";
    };
  };

}

