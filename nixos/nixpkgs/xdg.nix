{ pkgs, ... }:
let
  HOME_PATH = builtins.getEnv "HOME";
  TERMINAL_APP = builtins.getEnv "TERMINAL";
in

with pkgs; {
  enable = true;

  configFile = {
    # "polybar" = {
    #   source = ./xdg/polybar;
    #   recursive = true;
    # };
    "picom" = {
      source = ./xdg/picom;
      recursive = true;
    };

    "dunst" = {
      source = ./xdg/dunst;
      recursive = true;
    };

    "nnn" = {
      recursive = true;
      source = ../../commons/nnn;
    };

    "ranger" = {
      recursive = true;
      source = ../../commons/ranger;
    };

    "sxiv" = {
      recursive = true;
      source = ../../commons/sxiv;
    };

    "rofi/plugins/rofiemoji" = {
      source = fetchFromGitHub {
        name = "rofiemoji";
        owner = "nkoehring";
        repo = "rofiemoji";
        rev = "ad61572830c9d3c00e30eec078d46dad3cfdb4a2";
        sha256 = "16rhb2cs8cqwflkcyw5dr77alp5wik4bv1dg66m4hkgcplxv0dx0";
      };
    };

    "wallpapers" = {
      source = ../../wallpapers;
    };

    "sounds" = {
      source = ../../sounds;
    };

    "udiskie" = {
      source = ./xdg/udiskie;
    };

    # "conky" = {
    #   source = ./xdg/conky;
    # };
  };

  desktopEntries = {
    qt5ct = {
      comment = "QT5 Configuration Tool";
      exec = "qt5ct";
      genericName = "QT5 Configuration";
      icon = HOME_PATH + "/.local/share/custom-icons/qt_logo.svg";
      name = "QT5 Settings";
      terminal = false;
      type = "Application";
      categories = [ "Settings" "DesktopSettings" "Qt" ];
    };

    lxappearance = {
      comment = "Customize look and feel of your desktop and applications";
      exec = "lxappearance";
      genericName = "Customize look and Feel of GTK apps";
      icon = HOME_PATH + "/.local/share/custom-icons/gtk_logo.svg";
      name = "GTK Settings";
      terminal = false;
      type = "Application";
      categories = [ "GTK" "Settings" "DesktopSettings" "X-LXDE-Settings" ];
    };

    pavucontrol = {
      comment = "Adjust the volume level";
      exec = "pavucontrol";
      genericName = "Volume control";
      icon = HOME_PATH + "/.local/share/custom-icons/pavucontrol.svg";
      name = "Pulseaudio Volume Control";
      terminal = false;
      type = "Application";
      categories = [ "AudioVideo" ];
    };

    gsh = {
      comment = "Genially dev-env";
      exec = TERMINAL_APP + " -e gsh";
      genericName = "Genially Dev Env";
      icon = HOME_PATH + "/.local/share/custom-icons/genially_logo.svg";
      name = "gsh";
      terminal = false;
      type = "Application";
    };

    pcmanfm = {
      comment = "Browse the file system and manage the files";
      exec = "pcmanfm %U";
      genericName = "File Manager";
      icon = HOME_PATH + "/.local/share/custom-icons/pcmanfm.svg";
      name = "File Manager PCManFM";
      terminal = false;
      type = "Application";
      categories = [ "Settings" ];
    };

    ranger = {
      comment = "Launches the ranger file manager";
      exec = TERMINAL_APP + " -e ranger";
      genericName = "Terminal File Manager";
      icon = HOME_PATH + "/.local/share/custom-icons/ranger_logo.svg";
      name = "Ranger";
      terminal = false;
      type = "Application";
      categories = [ "Settings" ];
    };

    "com.yubico.authenticator" = {
      comment = "Yubico Authenticator app";
      exec = "authenticator";
      genericName = "Yubico Authenticator";
      icon = HOME_PATH + "/.nix-profile/app/linux_support/com.yubico.yubioath.png";
      name = "Yubico Authenticator";
      terminal = false;
      type = "Application";
      categories = [ "Utility" ];
    };
  };

  mimeApps = {
    enable = true;

    defaultApplications =
      let
        browser = google-chrome;
        google-chrome = "google-chrome.desktop";
        slack = "org.pwmt.zathura.desktop";
        sxiv = "sxiv.desktop";
        zathura = "org.pwmt.zathura.desktop";
        alacritty = "Alacritty.desktop";
      in
      {
        "application/pdf" = zathura;
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/x-extension-xht" = browser;
        "application/x-extension-xhtml" = browser;
        "application/xhtml+xml" = browser;

        "image/png" = sxiv;
        "text/html" = browser;

        "x-scheme-handler/chrome" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/slack" = slack;
      };
  };
}


