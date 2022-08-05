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
    # extraModulePackages =
    #   with config.boot.kernelPackages; [
    #     rtl8812au
    #   ];

    # initrd.kernelModules = [ "8812au" ];
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
    # firewall = {
    #   enable = true;
    #   allowedTCPPorts = [ 3000 4242 5001 ];
    # };

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
      # xkbOptions = "caps:escape";

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

    flatpak = {
      enable = true;
    };

    blueman.enable = true;
    cron.enable = true;
    geoclue2.enable = true;
    # ofono.enable = true;
    # ofono.plugings = [ pkgs. ofono-phonesim-unstable ];

    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };

    avahi = {
      enable = true;
    };

    # This config is needed to work wiz Bazecor
    udev = {
      extraRules = ''
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2201", GROUP="users", MODE="0666"
      '';
    };

    # dnsmasq = {
    #   enable = true;
    #   extraConfig = ''
    #     server=/genially.com/10.1.0.2
    #   '';
    # };

    openvpn = {
      servers = {
        genially = {
          autoStart = false;
          config = ''config /home/ajmasia/.config/vpn/genially_dev.ovpn'';
          updateResolvConf = true;
        };
        proton = {
          autoStart = false;
          config = ''config /home/ajmasia/.config/vpn/ch-lt-01.protonvpn.net.udp.ovpn'';
          updateResolvConf = true;
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
      # extraModules = [ pkgs.pulseaudio-modules-bt ];
    };

    bluetooth = {
      enable = true;
      settings = {
        General = {
          ControllerMode = "bredr";
          # Enable = "Source,Sink,Media,Socket";
        };
      };
    };

    opengl = {
      enable = true;
    };
    # enableAllFirmware = true;
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
  };
  users.extraGroups.vboxusers.members = [ "ajmasia" ];

  environment = {
    etc = {
      openvpn = {
        source = "${pkgs.update-resolv-conf}/libexec/openvpn";
      };
    };

    variables = {
      EDITOR = "vim";
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };

    systemPackages = with pkgs; [
      gnupg
      wget
      vim
      git
      # ofono-phonesim
      neovim-nightly
      home-manager
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs = {
    gnupg = {
      agent = {
        enable = true;
      };
    };
    vim = {
      defaultEditor = true;
    };
    steam = {
      enable = true;
    };
  };

  xdg = {
    portal = {
      enable = true;
    };
  };

  system = {
    stateVersion = "21.11";
  };
}
