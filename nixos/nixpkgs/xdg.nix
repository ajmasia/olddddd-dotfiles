{ pkgs, ... }:

with pkgs; {
  enable = true;

  configFile = {
    # "polybar" = {
    #   source = ./xdg/polybar;
    #   recursive = true;
    # };

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


