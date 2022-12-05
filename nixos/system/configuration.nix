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

    udev = {
      extraRules = ''
        # This config is needed to work with Bazecor
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2201", GROUP="users", MODE="0666"
        # This config optimize the battery power
        SUBSYSTEM=="power_supply", KERNEL=="AC0", DRIVER=="", ATTR{online}=="1", RUN+="${pkgs.ryzenadj}/bin/ryzenadj --tctl-temp=95 --slow-limit=15000 --stapm-limit=15000 --fast-limit=25000 --power-saving"
        SUBSYSTEM=="power_supply", KERNEL=="AC0", DRIVER=="", ATTR{online}=="0", RUN+="${pkgs.ryzenadj}/bin/ryzenadj --tctl-temp=95 --slow-limit=10000 --stapm-limit=10000 --fast-limit=10000 --power-saving"
      '';
    };

    udisks2 = {
      enable = true;
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

    # Daemon for delivering ACPI events
    acpid = {
      enable = true;
    };

    # Daemon for saving laptop battery power
    tlp = {
      enable = true;

      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        # The following prevents the battery from charging fully to preserve lifetime
        # Run `tlp fullcharge` to temporarily force full charge
        # https://linrunner.de/tlp/faq/battery.html#how-to-choose-good-battery-charge-thresholds
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
        NATACPI_ENABLE = 1;
        # 100 being the maximum, limit the speed of my CPU to reduce heat and increase battery usage
        CPU_MAX_PERF_ON_AC = 80;
        CPU_MAX_PERF_ON_BAT = 60;
        DEVICES_TO_DISABLE_ON_BAT = "bluetooth";
        RADEON_POWER_PROFILE_ON_AC = "auto";
        RADEON_POWER_PROFILE_ON_BAT = "auto";
      };
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
    };
  };

  users = {
    users = {
      ajmasia = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "input" "audio" ];
      };
    };

    extraGroups = {
      vboxusers = {
        members = [ "ajmasia" ];
      };
    };
  };

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
    # free implementation of the OpenPGP
    gnupg = {
      agent = {
        enable = true;
      };
    };

    vim = {
      defaultEditor = true;
    };
  };

  xdg = {
    # Enable XDG desktop integration
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

  systemd = {
    services.awake = {
      enable = true;

      after = [ "suspend.service" ];
      script = '' 
        sleep 15 && ${pkgs.ryzenadj}/bin/ryzenadj --tctl-temp=95 --slow-limit=15000 --stapm-limit=15000 --fast-limit=25000 --power-saving &>/dev/null
      '';
      wantedBy = [ "suspend.service" ];
    };
  };

  system = {
    stateVersion = "21.11";
  };
}
