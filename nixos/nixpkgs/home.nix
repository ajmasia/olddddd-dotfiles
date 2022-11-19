{ pkgs, ... }:

let
  USER = builtins.getEnv "USER";
  HOME_PATH = builtins.getEnv "HOME";
  EDITOR = "nvim";
in
with pkgs; {
  home = {
    username = USER;
    homeDirectory = HOME_PATH;
    stateVersion = "21.05";

    sessionVariables = {
      CM_LAUNCHER = "rofi";
    };

    keyboard = {
      layout = "us";
      variant = "altgr-intl";
    };

    packages = (import ./packages.nix) pkgs;
    file = (import ./files.nix) { };
  };

  # accounts.email = {
  #   accounts.genially = {
  #     address = "antoniomasia@genial.ly";
  #     aliases = ["antoniomasia@genially.com"];
  #     flavor = "gmail.com";

  #     imap = {
  #       host = "imap.gmail.com";
  #       tls.enable = true;
  #     };

  #     mu.enable = true;

  #     offlineimap = {
  #       enable = true;
  #       extraConfig.account.autorefresh = 10;
  #     };

  #     #passwordCommand = "get_pass gmail";
  #     primary = true;
  #     realName = "Antonio José Masiá";
  #   };

  #   certificatesFile = "/etc/ssl/certs/ca-certificates.crt";
  # };

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
          "pointer_action2" = "resize_corner";
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
          };
          "TelegramDesktop" = {
            desktop = "^3";
            state = "tiled";
          };
        };
        startupPrograms = [ ];
        extraConfig = ''
          pkill sxhkd
          pgrep -x sxhkd > /dev/null || sxhkd &
          
          ~/.config/polybar/launch.sh 

          systemctl --user restart picom.service
          
          feh --bg-fill ~/.config/wallpapers/wallpaper_004.jpg
          pkill xautolock
          xautolock -time 12 -locker "xscreensaver-command -deactivate; sleep 5; betterlockscreen -l" -notify 15 -notifier "notify-send 'Locker' 'Locking screen in 15 seconds' -t 4000" -killtime 10 -killer "systemctl suspend" &
          
          pkill battery-notifier
          battery-notifier &

          pkill -f cloud-drive-con
          pkill -f cloud-drive*
          synology-drive &

          xsetroot -cursor_name left_ptr &

          play ~/.config/sounds/startup-01.mp3 &

          laptop_screen_state=$(bat /proc/acpi/button/lid/LID1/state | awk '{print $2}')
          is_external_monitor_connected=$(xrandr --query | grep 'HDMI-1 connected')

          if [[ $is_external_monitor_connected == "" ]]; then
            bspc monitor eDP-1 -d I II III IV V VI VII VIII
            # bspc rule -a Alacritty -o desktop='^1' follow=on focus=on && /home/ajmasia/.nix-profile/bin/alacritty &
            # bspc rule -a TelegramDesktop -o desktop='^7' && /home/ajmasia/.nix-profile/bin/telegram-desktop &
            # bspc rule -a Slack -o desktop='^8' && /home/ajmasia/.nix-profile/bin/slack 
          elif [[ $laptop_screen_state == "open" ]]; then
            bspc monitor eDP-1 -d VII VIII IX X
            bspc monitor HDMI-1 -f -d I II III IV V VI
            # bspc rule -a TelegramDesktop -o desktop='^3' && /home/ajmasia/.nix-profile/bin/telegram-desktop &
            # bspc rule -a Slack -o desktop='^4' && /home/ajmasia/.nix-profile/bin/slack &
            # bspc rule -a Alacritty -o desktop='^5' && /home/ajmasia/.nix-profile/bin/alacritty &
            # bspc rule -a Alacritty -o desktop='^1' follow=on focus=on && /home/ajmasia/.nix-profile/bin/alacritty
          else
            bspc monitor HDMI-1 -d I II III IV V VI VII VIII
            # bspc rule -a Alacritty -o desktop='^1' follow=on focus=on && /home/ajmasia/.nix-profile/bin/alacritty &
            # bspc rule -a TelegramDesktop -o desktop='^7' && /home/ajmasia/.nix-profile/bin/telegram-desktop &
            # bspc rule -a Slack -o desktop='^8' && /home/ajmasia/.nix-profile/bin/slack 
          fi 
        '';
      };
    };
  };

  xdg = (import ./xdg.nix) { pkgs = pkgs; };
  programs = (import ./programs.nix) { pkgs = pkgs; lib = lib; builtins = builtins; };
  services = (import ./services.nix) { };
  fonts.fontconfig.enable = true;
}


