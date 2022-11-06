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
      # dns = "dnsmasq";
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

        awesome = {
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

    # This config is needed to work with Bazecor
    udev = {
      extraRules = ''
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2201", GROUP="users", MODE="0666"
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
      guest = {
        enable = true;
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
            {
              command = "/run/current-system/sw/bin/systemctl";
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
