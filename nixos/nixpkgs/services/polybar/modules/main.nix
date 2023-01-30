{ ... }:

let
  os = builtins.readFile ./os.ini;
  os-name = builtins.readFile ./os-name.ini;
  workspaces = builtins.readFile ./workspaces.ini;
in

builtins.concatStringsSep "" [
  os
  os-name
  workspaces
]
