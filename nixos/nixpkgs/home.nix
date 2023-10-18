{ pkgs, ... }:

let
  unstable = import <unstable> { };

  USER = builtins.getEnv "USER";
  HOME_PATH = builtins.getEnv "HOME";
  dayTheme = "Nordic-Polar";
  nightTheme = "Nordic";
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

  accounts.email = {
    accounts.genially = {
      address = "antoniomasia@genially.com";

      himalaya.enable = true;
      imap = {
        host = "imap.gmail.com";
        tls.enable = true;
      };

      offlineimap = {
        enable = true;
        extraConfig.account.autorefresh = 10;
      };

      #passwordCommand = "get_pass gmail";
      primary = true;
      realName = "Antonio José Masiá";
    };
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
            desktop = "^1";
            sticky = true;
            state = "floating";
            center = true;
            rectangle = "1896x1056+100+100";
          };
          "TelegramDesktop" = {
            desktop = "^1";
            sticky = true;
            state = "floating";
            center = true;
            rectangle = "1896x1056+100+100";
          };
          "1Password" = {
            sticky = true;
            state = "floating";
            center = true;
            rectangle = "1896x1056+100+100";
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
          "Bitwarden" = {
            state = "floating";
            center = true;
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
          "scpad" = {
            sticky = true;
            state = "floating";
            center = true;
            rectangle = "1896x1056+100+100";
          };
          "Evolution:evolution-mail-preview" = {
            state = "floating";
            center = true;
          };
        };

        startupPrograms = [
          "# Startup programs"
          "systemctl --user restart picom.service"
          "pgrep -x sxhkd > /dev/null || sxhkd"
          "xsetroot -cursor_name left_ptr"
          # "fusuma -d"
          "~/.config/conky/Mimosa_DBlue/start.sh"
          "xautolock -time 12 -locker \"xscreensaver-command -deactivate; sleep 5; betterlockscreen -l\" -notify 15 -notifier \"notify-send 'Locker' 'Locking screen in 15 seconds' -t 4000\" -killtime 10 -killer \"systemctl suspend\""
          "solaar -w=hide -b=solaar"
          "batsignal -n BAT0 -c 20 -w 30 -f 98 -I ~/.local/share/custom-icons/battery.png"
          "sleep 3 && synology-drive"
          "cbatticon"
          # "sleep 2 && qsyncthingtray"
          "bspc_initialize-monitors"
          "feh --bg-fill ~/.config/wallpapers/wallpaper_bigsur-macos_light.jpg"
          "~/.config/polybar/launch.sh"
        ];

        extraConfig = ''
          # Kill running services
          pkill polybar
          pkill sxhkd
          pkill xautolock
          # pkill fusuma
          pkill solaar
          pkill batsignal
          pkill -f cloud-drive-con
          pkill -f cloud-drive* 
          pkill cbatticon
          # pkill qsyncthingtray
          killall conky
        '';
      };
    };
  };

  xdg = (import ./xdg.nix) { pkgs = pkgs; };
  programs = (import ./programs.nix) { pkgs = pkgs; lib = lib; builtins = builtins; };
  services = (import ./services.nix) { pkgs = pkgs; };
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

    protonmail-bridge = {
      Unit = {
        Description = "Protonmail Bridge";
        After = [ "network.target" ];
      };
      Service = {
        Restart = "always";
        Environment = "PATH=${pkgs.gnome3.gnome-keyring}/bin";
        ExecStart = "${unstable.protonmail-bridge}/bin/protonmail-bridge --no-window --noninteractive";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
  systemd.user.services.my-lid-watcher = {
    Unit = {
      Description = "Mi servicio para observar los cambios de LID";
      Wants = [ "lid-switch.target" ];
      After = [ "lid-switch.target" ];
    };

    Service = {
      ExecStart = "${pkgs.runtimeShell} DISPLAY=:0 ${pkgs.libnotify}/bin/notify-send 'LID CHANGE'";
      RemainAfterExit = true;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = nightTheme;
      package = nordic;
    };
    iconTheme = {
      # name = "Papirus-Dark";
      # name = "Tela-circle";
      # name = "obsidian";
      # name = "Vimix";
      name = "Numix-Circle";
      # package = papirus-icon-theme; 
      # package = tela-circle-icon-theme;
      # package = vimix-icon-theme;
      package = numix-icon-theme-circle;
    };
  };

  imports = builtins.concatMap import [
    ./programs
  ];

}


