{ pkgs, ... }:

with pkgs; {
  enable = true;

  configFile = {
    "bspwm" = {
      source = ./xdg/bspwm;
      recursive = true;
      executable = true;
    };

    "polybar" = {
      source = ./xdg/polybar;
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
}


