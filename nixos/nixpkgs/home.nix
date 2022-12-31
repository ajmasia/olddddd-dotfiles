{ pkgs, ... }:

let
  USER = builtins.getEnv "USER";
  HOME_PATH = builtins.getEnv "HOME";
in
with pkgs; {
  home = {
    username = USER;
    homeDirectory = HOME_PATH;
    stateVersion = "21.05";

    sessionVariables = {
      CM_LAUNCHER = "rofi";
      TERMINAL = "alacritty";
      EDITOR = "nvim";
    };

    keyboard = {
      layout = "us";
      variant = "altgr-intl";
    };

    packages = (import ./packages.nix) pkgs;
    file = (import ./files.nix) { };
  };

  xsession = {
    enable = true;

    windowManager = {
      bspwm = {
        enable = true;

        settings = {
          "border_width" = 0;
          "window_gap" = 12;
          "ignore_ewmh_struts" = "";
          "focus_follows_pointer" = true;
          "remove_disabled_monitors" = true;
          "merge_overlapping_monitors" = true;
          "pointer_follows_monitor" = true;
          "pointer_modifier" = "mod4";
          "pointer_action1" = "move";
          # "pointer_action2" = "resize_side";
          "pointer_action2" = "resize_corner";
          "automatic_scheme" = "spiral";
          "initial_polarity" = "first_child";
          "pointer_motion_interval" = 0.8;
        };
        rules = {
          "Zathura" = {
            state = "tiled";
          };
          "Todoist" = {
            state = "floating";
            follow = true;
            focus = true;
          };
          "Galculator" = {
            state = "floating";
            follow = true;
            focus = true;
          };
          "Slack" = {
            desktop = "^4";
            state = "tiled";
            follow = false;
            focus = false;
          };
          "TelegramDesktop" = {
            desktop = "^3";
            state = "tiled";
          };
          "Nm-connection-editor" = {
            state = "floating";
            center = true;
            rectangle = "800x600+100+100";
          };
          ".blueman-manager-wrapped" = {
            state = "floating";
            center = true;
            rectangle = "800x600+100+100";
          };
          "Pavucontrol" = {
            state = "floating";
            center = true;
            rectangle = "800x600+100+100";
          };
          "Lxappearance" = {
            state = "floating";
            center = true;
            rectangle = "1000x800+100+100";
          };
          "qt5ct" = {
            state = "floating";
            center = true;
            rectangle = "1000x800+100+100";
          };
        };
        startupPrograms = [ ];
        extraConfig = ''
          # Launch hotkey manager
          pkill sxhkd
          pgrep -x sxhkd > /dev/null || sxhkd &

          # Launch picom compositor
          pkill picom
          picom &

          # Launch status bar
          sleep 2 && ~/.config/polybar/launch.sh &

          # Set desktop background
          feh --bg-fill ~/.config/wallpapers/wallpaper_004.jpg

          # Laucnh conky
          ~/.config/conky/Mimosa_DBlue/start.sh &

          # Launch starter sound
          play ~/.config/sounds/startup-01.mp3 &

          # Set sutolock screen 
          pkill xautolock
          xautolock -time 12 -locker "xscreensaver-command -deactivate; sleep 5; betterlockscreen -l" -notify 15 -notifier "notify-send 'Locker' 'Locking screen in 15 seconds' -t 4000" -killtime 10 -killer "systemctl suspend" &
          
          # pkill battery-notifier
          # battery-notifier &

          xsetroot -cursor_name left_ptr &

          # Initialize bspw monitors & desktops
          laptop_screen_state=$(bat /proc/acpi/button/lid/LID1/state | awk '{print $2}')
          is_external_monitor_connected=$(xrandr --query | grep 'HDMI-A-0 connected')

          if [[ $is_external_monitor_connected == "" ]]; then
            bspc monitor eDP -d I II III IV V VI VII VIII
            # bspc rule -a Alacritty -o desktop='^1' follow=on focus=on && /home/ajmasia/.nix-profile/bin/alacritty &
            # bspc rule -a TelegramDesktop -o desktop='^7' && /home/ajmasia/.nix-profile/bin/telegram-desktop &
            # bspc rule -a Slack -o desktop='^8' && /home/ajmasia/.nix-profile/bin/slack 
          elif [[ $laptop_screen_state == "open" ]]; then
            bspc monitor eDP -d VII VIII IX X
            bspc monitor HDMI-A-0 -f -d I II III IV V VI
            # bspc rule -a TelegramDesktop -o desktop='^3' && /home/ajmasia/.nix-profile/bin/telegram-desktop &
            # bspc rule -a Slack -o desktop='^4' && /home/ajmasia/.nix-profile/bin/slack &
            # bspc rule -a Alacritty -o desktop='^5' && /home/ajmasia/.nix-profile/bin/alacritty &
            # bspc rule -a Alacritty -o desktop='^1' follow=on focus=on && /home/ajmasia/.nix-profile/bin/alacritty
          else
            bspc monitor HDMI-A-0 -d I II III IV V VI VII VIII
            # bspc rule -a Alacritty -o desktop='^1' follow=on focus=on && /home/ajmasia/.nix-profile/bin/alacritty &
            # bspc rule -a TelegramDesktop -o desktop='^7' && /home/ajmasia/.nix-profile/bin/telegram-desktop &
            # bspc rule -a Slack -o desktop='^8' && /home/ajmasia/.nix-profile/bin/slack 
          fi 

          # Launch battery service notifications
          pkill cbatticon
          sleep 4 && cbatticon -i 'standard' -l 30 -r 19 &

          # Launch Synology Drive service
          pkill -f cloud-drive-con
          pkill -f cloud-drive*
          sleep 8 && synology-drive &
        '';
      };
    };
  };

  xdg = (import ./xdg.nix) { pkgs = pkgs; };
  programs = (import ./programs.nix) { pkgs = pkgs; lib = lib; builtins = builtins; };
  services = (import ./services.nix) { };
  fonts.fontconfig.enable = true;

  systemd.user.services = {
    polkit-gnome-authentication-agent-1 = {
      Unit = {
        After = [ "graphical-session-pre.target" ];
        Description = "polkit-gnome-authentication-agent-1";
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
        Type = "simple";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = nordic;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = papirus-icon-theme;
    };
  };
}


