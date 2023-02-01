# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
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

    pam.yubico = {
      enable = true;
      debug = false;
      mode = "challenge-response";
    };

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

    # Needed to some apps like blueman-manager save their options
    dbus.packages = [ pkgs.dconf ];

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
        # gdm = {
        #   enable = true;
        # };
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
        genially = {
          autoStart = false;
          config = ''config /home/ajmasia/.config/vpn/genially_dev.ovpn'';
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

    # Daemon for delivering ACPI events
    acpid = {
      enable = true;
    };
  };

  # Power management service. Includes support for suspend-to-RAM and powersave features on laptop
  powerManagement = {
    enable = true;

    cpuFreqGovernor = "ondemand";
    powerUpCommands = "${awake}/bin/awake";
    resumeCommands = "${awake}/bin/awake";

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
    # Enable XDG desktop integration
    portal = {
      enable = true;
    };
  };

  # systemd.services.wg-quick-garage-vpn.wantedBy = pkgs.lib.mkForce [ ];

  system = {
    stateVersion = "21.11";
  };
}
