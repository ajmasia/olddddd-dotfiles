{ pkgs, ... }:
let
  custom-polybar-package = pkgs.polybar.override {
    alsaSupport = true;
    githubSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  };

  main-bar = pkgs.callPackage ./bars/latop.nix { };
  colors = builtins.readFile ./utils/colors.ini;
  separators = builtins.readFile ./utils/separators.ini;
  modules = pkgs.callPackage ./modules/main.nix { };
in
{
  enable = false;

  package = custom-polybar-package;

  config = ./config.ini;
  extraConfig = colors + separators + modules + main-bar;
  script = ''
    # polybar laptop 2>~/.config/polybar/laptop.log & disown

    DIR="$HOME/.config/polybar"
    # Terminate already running bar instances
    # pkill polybar

    # Wait until the processes have been shut down
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

    # Launch the bar

    laptop_screen_state=$(bat /proc/acpi/button/lid/LID1/state | awk '{print $2}')
    is_external_monitor_connected=$(xrandr --query | grep 'DVI-I-1-1 connected')

    echo $laptop_screen_state
    echo $is_external_monitor_connected

    if [[ $is_external_monitor_connected == "" ]]; then
      polybar -q laptop -c "$DIR"/config.ini & 
    elif [[ $laptop_screen_state == "open" ]]; then
      xrandr --output DVI-I-1-1 --primary --output eDP-1 --auto --left-of DVI-I-1-1
      polybar -q main-home -c "$DIR"/config.ini &
      polybar -q secondary-laptop -c "$DIR"/config.ini &
    else
      xrandr --output eDP-1 --off
      polybar -q external -c "$DIR"/config.ini &
    fi
  '';
}
