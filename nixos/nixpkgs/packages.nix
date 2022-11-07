{ pkgs, ... }:
let
  unstablePackages = import <unstable> { };
  extraNodePackages = import ./node/default.nix { };
  yarnWithNode16 = pkgs.yarn.overrideAttrs (oldAttrs: rec {
    buildInputs = with pkgs; [
      nodejs-16_x
    ];
  });
  nixpkgs_for_insync3 = with pkgs; callPackage
    (fetchFromGitHub {
      name = "nixpkgs";
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "b49473e6679c733f917254b786bfac42339875eb";
      sha256 = "1yan995h228v18b6hcjgvkbnaxwbbrink5if4ggvdans9mczcgfw";
    })
    { };
  # custom-nerdfonts = (pkgs.nerdfonts.override { 
  #   fonts = [ "FiraCode" "DroidSansMono" "Hack" "SourceCodePro" "CascadiaCode"]; 
  # });
in
with pkgs; [
  # System
  brightnessctl
  pavucontrol

  # Tools
  bc
  exa
  fd
  file
  fzf
  fzy
  fd
  htop
  ripgrep
  tmux
  tmuxp
  tldr
  xclip
  unzip
  zip
  libnotify
  ajmasia-bin
  lm_sensors
  graphviz
  killall
  ueberzug
  networkmanager-openvpn
  openvpn
  bpytop
  woeusb
  sox
  qsudo
  qt5ct
  galculator
  system-config-printer
  direnv
  conky
  kubectl
  kubectx
  polkit
  etcher
  di
  lfs
  neofetch
  fortune
  lolcat
  btop
  etcher
  ryzenadj
  lazygit

  yubioath-desktop
  yubikey-manager

  # Terminal
  wezterm

  # Useless
  cmatrix

  # Plugins
  # networkmanager-openvpn

  # File system
  appimage-run
  pcmanfm
  ranger
  nnn

  # Mail clients
  mailspring

  # File viewers
  sxiv

  # Fonst
  nerdfonts
  # custom-nerdfonts
  font-awesome_5

  # UI
  xdragon
  kazam
  feh
  polybarFull
  xautolock
  betterlockscreen
  lxappearance

  # Browsers
  #chromium
  unstablePackages.google-chrome
  firefox

  # Comunications
  tdesktop
  slack
  discord
  telegram-cli

  # Multimedia
  spotify
  pamix
  cava
  vlc

  # Graphical editors
  inkscape
  gimp

  # others
  home-assistant-cli

  # Productivity
  timewarrior
  calibre
  # todoist-electron
  todoist
  bitwarden
  bitwarden-cli
  unstablePackages.obsidian
  pdfarranger
  _1password
  _1password-gui
  # unstablePackages.synology-drive-client
  synology_drive_client_12920
  nixpkgs_for_insync3.insync-v3
  # inkdrop

  # Development
  # editors
  (emacsWithPackages (epkgs: [ epkgs.emacsql-sqlite ]))
  unstablePackages.neovim
  unstablePackages.vscode
  thonny

  # interprets
  python3Full
  nodejs-16_x
  yarnWithNode16

  # python packages
  python39Packages.pyqt5
  python39Packages.pip

  # tools
  gsh
  docker-compose
  jq

  # generators
  hugo

  # compilers
  gnumake
  gcc

  # lsp
  stylua
  selene
  black
  sumneko-lua-language-server

  # packages managers
  unstablePackages.cargo

  # node packages
  nodePackages.node2nix
  nodePackages.neovim
  extraNodePackages.rtm-cli
  # nodePackages.eslint
  # nodePackages.prettier
  # nodePackages.typescript-language-server
  # nodePackages.vscode-langservers-extracted

  # python packages
  # python39Packages.flake8

  # db
  sqlite
  pgcli

  # playgorund
  rpiplay
]

