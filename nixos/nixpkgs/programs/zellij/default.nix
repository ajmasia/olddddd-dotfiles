{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;

    settings = {
      themes = {
        default = {
          fg = "#A9B1D6";
          bg = "#1A1B26";
          black = "#383E5A";
          red = "#F9334D";
          green = "#9ECE6A";
          yellow = "#E0AF68";
          blue = "#7AA2F7";
          magenta = "#BB9AF7";
          cyan = "#2AC3DE";
          white = "#C0CAF5";
          orange = "#FF9E64";
        };
      };
    };
  };
}

