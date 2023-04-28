{ pkgs, ... }:
let
  unstable = import <unstable> { };
  # extraNodePackages = import ./node/default.nix { };
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
  custom-nerdfonts = (pkgs.nerdfonts.override { 
    fonts = [ "FiraCode" "DroidSansMono" "Hack" "SourceCodePro" "CascadiaCode"]; 
  });
  customNodePackages = pkgs.callPackage ./node-packages { };
in
with pkgs; [
  # System
  brightnessctl
  pavucontrol

  # Tools
  # ticktick
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
  # lens
  lens-last
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
  awscli2
  cairo
  ipinfo
  batsignal
  robo3t
  # unstable.dt-shell-color-scripts
  # usermount
  acpi
  lsof
  jrnl
  playerctl
  zscroll
  at-spi2-core # Assistive Technology Service Provider Interface protocol definitions and daemon for D-Bus
  # scc
  xorg.xwininfo
  xdotool
  xdo

  github-desktop
  gh

  # Privacy
  # protonvpn-gui
  # protonvpn-cli

  unstable.yubioath-flutter
  yubikey-personalization
  yubikey-manager

  geekbench5

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
  # mailspring
  unstable.tutanota-desktop # Tutanota Desktop Client
  unstable.protonmail-bridge # ProtonMail Bridge
  thunderbird # Thunderbird Mail Client

  # File viewers
  sxiv
  evince # PDF viewer

  # File sync and backup
  # insync-v3 // is broken

  # Fonst
  unstable.nerdfonts
  # google-fonts
  # custom-nerdfonts
  font-awesome_5
  # material-icons

  # UI
  xdragon
  kazam
  feh
  polybarFull
  webcamoid
  cbatticon
  # qsyncthingtray

  # picom-jonaburg
  xautolock
  betterlockscreen
  lxappearance # Configuring the theme and fonts of gtk applications
  libsForQt5.qt5ct # Qt5 Configuration Tool
  gnome.gnome-disk-utility
  # gnome.nautilus
  # adwaita-qt
  networkmanagerapplet
  # papirus-icon-theme
  sioyek
  bsp-layout
  spotify-tray
  # google-cloud-sdk
  # meteo
  autokey

  # Browsers
  #chromium
  unstable.google-chrome
  firefox
  brave

  # Comunications
  tdesktop
  slack
  discord
  telegram-cli
  element-desktop # Matrix client
  signal-desktop # Signal messenger

  # Multimedia
  spotify
  pamix
  cava
  vlc
  handbrake


  # Graphical editors
  inkscape
  gimp

  # others
  home-assistant-cli

  # Productivity
  timewarrior
  calibre
  todoist
  todoist-electron
  bitwarden
  bitwarden-cli
  unstable.obsidian
  pdfarranger
  _1password
  _1password-gui
  # unstable.synology-drive-client
  synology_drive_client_12920
  # nixpkgs_for_insync3.insync-v3
  # inkdrop
  libreoffice

  # Development
  # editors
  # (emacsWithPackages (epkgs: [ epkgs.emacsql-sqlite ]))
  neovim
  # unstable.vscode
  unstable.jetbrains.webstorm
  thonny

  # interprets
  python3Full
  nodejs-16_x
  yarnWithNode16

  # haskell
  stack
  ghc

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
  gcc
  gnumake
  cmake

  # LUA lsp
  stylua
  sumneko-lua-language-server

  # packages managers
  unstable.cargo

  # node packages
  nodePackages.node2nix
  nodePackages.neovim
  # nodePackages.eslint
  # nodePackages.prettier
  # nodePackages.typescript-language-server
  # nodePackages.vscode-langservers-extracted
  nodePackages_latest.eslint_d

  # python packages
  # python39Packages.flake8

  # db
  sqlite
  pgcli
  dbeaver
  beekeeper-studio

  # playgorund
  rpiplay

  luajitPackages.luarocks
  customNodePackages.autocannon
  customNodePackages.fastify-cli

  # insomnia
]

