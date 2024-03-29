{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;

    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./themes/spotlight-dark.rasi;
    plugins = [ pkgs.rofi-emoji ];
  };
}
