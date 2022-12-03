# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    kernel.sysctl."kernel.sysrq" = 1;
    loader = {
      timeout = 1;
      systemd-boot = {
        enable = true;
      };

      efi = {
        canTouchEfiVariables = true;
      };
    };

    plymouth = {
      enable = true;
    };
  };

  time = {
    timeZone = "Europe/Madrid";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  networking = {
    hostName = "genially-dev";
    useDHCP = false;

    networkmanager = {
      enable = true;
    };

    interfaces = {
      eno1 = {
        useDHCP = true;
      };

      wlp1s0 = {
        useDHCP = true;
      };
    };
  };

  security = {
    polkit = {
      enable = true;
    };
  };

  services = {
    accounts-daemon = {
      enable = true;
    };

    gnome.gnome-keyring.enable = true;
    gnome.core-utilities.enable = false;

    xserver = {
      enable = true;
      autorun = true;

      displayManager = {
        lightdm = {
          greeters = {
            enso = {
              enable = true;
            };
          };
        };
      };

      windowManager = {
        bspwm = {
          enable = true;
        };
      };

      layout = "us";
      xkbVariant = "altgr-intl";

      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = true;
          tapping = true;
          additionalOptions = ''
            MatchIsTouchpad "on"
          '';
        };
      };
    };

    blueman.enable = true;
    cron.enable = true;
    geoclue2.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };

    avahi = {
      enable = true;
    };

    pcscd = {
      enable = true;
    };

    # This config is needed to work with Bazecor
    udev = {
      extraRules = ''
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2201", GROUP="users", MODE="0666"
        # SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${pkgs.ryzenadj}/bin/ryzenadj --tctl-temp=95 --slow-limit=15000 --stapm-limit=15000 --fast-limit=25000 --power-saving"
      '';
    };

    openvpn = {
      servers = {
        genially = {
          autoStart = false;
          config = ''config /home/ajmasia/.config/vpn/genially_dev.ovpn'';
          updateResolvConf = true;
        };
        home = {
          autoStart = false;
          config = ''config /home/ajmasia/.config/vpn/home.ovpn'';
          authUserPass = {
            username = (import ./secrets.nix).home-vpn.user;
            password = (import ./secrets.nix).home-vpn.password;
          };
        };
      };
    };

    acpid = {
      enable = true;
    };

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";

        # The following prevents the battery from charging fully to
        # preserve lifetime. Run `tlp fullcharge` to temporarily force
        # full charge.
        # https://linrunner.de/tlp/faq/battery.html#how-to-choose-good-battery-charge-thresholds
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 50;

        # 100 being the maximum, limit the speed of my CPU to reduce
        # heat and increase battery usage:
        CPU_MAX_PERF_ON_AC = 75;
        CPU_MAX_PERF_ON_BAT = 60;
      };
    };

    cpupower-gui = {
      enable = true;
    };
  };

  sound = {
    enable = true;

    mediaKeys = {
      enable = true;
    };
  };

  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };

    bluetooth = {
      enable = true;
      settings = {
        General = {
          ControllerMode = "bredr";
        };
      };
    };

    opengl = {
      enable = true;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };

    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
      # guest = {
      #   enable = true;
      # };
    };
  };

  users = {
    users = {
      ajmasia = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "input" "audio" ];
      };
    };
  };
  users.extraGroups.vboxusers.members = [ "ajmasia" ];


  environment = {
    etc = {
      openvpn = {
        source = "${pkgs.update-resolv-conf}/libexec/openvpn";
      };
    };

    variables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };

    systemPackages = with pkgs; [
      gnupg
      ghc
      wget
      ryzenadj
      home-manager
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs = {
    gnupg = {
      agent = {
        enable = true;
      };
    };
    vim = {
      defaultEditor = false;
    };
  };

  xdg = {
    portal = {
      enable = true;
    };
  };

  security = {
    sudo = {
      enable = true;
      extraRules = [
        {
          users = [ "ajmasia" ];
          commands = [
            {
              command = "/home/ajmasia/.nix-profile/bin/ryzenadj";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
  };

  system = {
    stateVersion = "21.11";
  };
}
