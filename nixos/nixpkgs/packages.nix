{ pkgs, ... }:
let
  unstablePackages = import <unstable> { };
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

  # Useless
  cmatrix

  # Plugins
  # networkmanager-openvpn

  # File system
  appimage-run
  pcmanfm
  ranger
  nnn

  # File viewers
  sxiv

  # Fonst
  font-manager
  nerdfonts
  font-awesome
  fira-code

  # UI
  dragon-drop
  kazam
  dunst
  feh
  # sxhkd
  polybar
  picom
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

  # Productivity
  timewarrior
  calibre
  todoist-electron
  todoist
  bitwarden
  bitwarden-cli
  obsidian
  pdfarranger
  _1password
  _1password-gui
  # unstablePackages.synology-drive-client
  synology_drive_client_12920
  nixpkgs_for_insync3.insync-v3
  inkdrop

  # Development
  # editors
  (emacsWithPackages (epkgs: [ epkgs.emacsql-sqlite ]))
  unstablePackages.neovim
  # vscode
  vscode_1_67

  # interprets
  python3
  nodejs-16_x
  yarnWithNode16

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
  cargo

  # node packages
  nodePackages.node2nix
  nodePackages.neovim
  # nodePackages.eslint
  # nodePackages.prettier
  # nodePackages.typescript-language-server
  # nodePackages.vscode-langservers-extracted

  # python packages
  # python39Packages.flake8
]

