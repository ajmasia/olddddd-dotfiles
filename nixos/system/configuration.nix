# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  unstable = import <unstable> { };
  # scripts = import ./scripts.nix { pkgs = pkgs; };
  secrets = import ./secrets.nix;

  scripts = import ./bin/scripts.nix { pkgs = pkgs; };
  awake = scripts.awake;
  awake-udev = scripts.awake-udev;
in
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

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true; # for solaar to be included

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

    wg-quick.interfaces = {
      garage-vpn = {
        autostart = false;
        address = [ "172.27.66.2/24" ];
        dns = [ "172.30.32.3" ];
        privateKey = secrets.wg.privateKey;

        peers = [
          {
            publicKey = "nKx9mrJhDocIoZzm2WUCtwORP+O4HvH7C4rSRBbVBnw=";
            # presharedKeyFile = "/root/wireguard-keys/preshared_from_peer0_key";
            allowedIPs = [ "0.0.0.0/0" ];
            endpoint = secrets.wg.endpoint;
            persistentKeepalive = 25;
          }
        ];
      };

    };
  };

  security = {
    polkit = {
      enable = true;
    };

    # PAM (Pluggable Authentication Modules) for Yubikey
    # pam.yubico = {
    #   enable = true;
    #   debug = false;
    #   mode = "challenge-response";
    # };

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

  services = {
    accounts-daemon = {
      enable = true;
    };

    # Use the system-wide dconf database with D-Bus
    dbus.packages = [ pkgs.dconf ];

    # Needed to some apps like blueman-manager or networkmanager to save their options
    gnome.gnome-keyring.enable = true;

    xserver = {
      enable = true;
      autorun = true;

      displayManager = {
        gdm = {
          enable = true;
        };
        defaultSession = "none+bspwm";
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

    # Zeroconf protocol implementation for service discovery
    avahi = {
      enable = true;
    };

    # PC/SC daemon for smart card readers. Needed for Yubikey
    pcscd = {
      enable = true;
    };

    udev = {
      packages = [ pkgs.yubikey-personalization ];
      extraRules = ''
        # This config is needed to work with Bazecor
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2201", GROUP="users", MODE="0666"

        # This config optimize the battery power
        SUBSYSTEM=="power_supply", KERNEL=="AC0", DRIVER=="", ATTR{online}=="1", RUN+="${awake-udev}/bin/awake-udev"
        SUBSYSTEM=="power_supply", KERNEL=="AC0", DRIVER=="", ATTR{online}=="0", RUN+="${awake-udev}/bin/awake-udev"
      '';
    };

    udisks2 = {
      enable = true;
    };

    openvpn = {
      servers = {
        work-dev = {
          autoStart = false;
          config = ''config /home/ajmasia/.config/vpn/5741013c6c2d30bffa6779fc2eecda6c.ovpn'';
          updateResolvConf = true;
        };

        work-pre = {
          autoStart = false;
          config = ''config /home/ajmasia/.config/vpn/b3841d78f5f012fee5cee00837b3e63d.ovpn'';
          updateResolvConf = true;
        };

        home = {
          autoStart = false;
          config = ''config /home/ajmasia/.config/vpn/home.ovpn'';
          authUserPass = {
            username = secrets.home-vpn.user;
            password = secrets.home-vpn.password;
          };
        };
      };
    };

    # Daemon for ACPI (Advanced Configuration and Power Interface) events
    acpid = {
      enable = false;
    };

    mullvad-vpn = {
      enable = true;
      package = unstable.mullvad-vpn;
    };
  };

  # Power management service. Includes support for suspend-to-RAM and powersave features on laptop
  powerManagement = {
    enable = true;

    cpuFreqGovernor = "ondemand";
    powerUpCommands = "sleep 10 && ${awake}/bin/awake &";
    resumeCommands = "sleep 10 && ${awake}/bin/awake";

    powertop = {
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
        enable = false;

        enableExtensionPack = true;
      };
    };
  };

  users = {
    users = {
      ajmasia = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "input" "audio" ];
        # homeMode = "755";
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
      awake
      awake-udev
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

    # Needed to some apps like blueman-manager save their options
    dconf.enable = true;
  };

  xdg = {
    # Enable D-Bus communication for sandboxed applications
    portal = {
      enable = true;
    };
  };

  # systemd.services.wg-quick-garage-vpn.wantedBy = pkgs.lib.mkForce [ ];

  system = {
    stateVersion = "21.11";
  };
}
