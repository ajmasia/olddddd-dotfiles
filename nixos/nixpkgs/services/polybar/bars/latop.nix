{ ... }:

let
  laptop = ''
    [bar/laptop]
  '';

  fonts = builtins.readFile ../utils/fonts.ini;

  settings = ''
    monitor = eDP-1
    monitor-fallback =
    monitor-strict = false

    enable-ipc = true

    override-redirect = false
    bottom = false
    fixed-center = true

    width = 100%:-24
    height = 36

    offset-x = 12
    offset-y = 12

    tray-position = center
    tray-detached = true
    tray-offset-x = 0
    tray-offset-y = 0
    tray-background = ''${color.bg}
    tray-foreground = ''${color.fg}
    tray-maxsize = 20
    tray-scale = 1.0

    background = ''${color.bg}
    foreground = ''${color.fg}

    radius = 8

    underline-size = 0
    underline-colors = ''${color.fg}

    padding-right = 2
    padding-left = 2

    module-margin-left = 0
    module-margin-right = 0

    modules-left = os sep-2 os-name os-name-os sep-2 workspaces 
    modules-right = date

    wm-restack = bspwm

    cursor-click  = pointer
    cursor-scroll = ns-resize
  '';
in

builtins.concatStringsSep "" [
  laptop
  fonts
  settings
]
