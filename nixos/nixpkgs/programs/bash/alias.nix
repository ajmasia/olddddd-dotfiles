import ../../../../commons/alias/commons.nix //
  import ../../../../commons/alias/git.nix //
  import ../../../../commons/alias/docker.nix //
{
  # directories
  gmo = "cd ~/projects/genially/mono && gsh shell";
  gdb = "cd ~/projects/genially/dev-databases && gsh shell";
  ged = "cd ~/projects/genially/mono && gsh run ed";
  sd = "cd ~/synology_drive";
  pr = "cd ~/projects";
  rp = "cd ~/repos";
  dw = "cd ~/downloads";
  syn = "cd ~/synology-drive";


  # vpn
  gdev-vpn = "sudo openvpn ~/.config/vpn/genially_dev.ovpn";

  # apps 
  bazecor = "appimage-run ~/.local/share/app-images/Bazecor-1.3.0-x86_64.AppImage";

  # genially project
  grp = "yarn clean:modules && yarn && gsh cli builder --all";

  # Programs
  r3t = "nix-shell -p robo3t --run robo3t &";
  calc = "env GTK_THEME=Adwaita ~/.nix-profile/bin/libreoffice --calc &";
  base = "env GTK_THEME=Adwaita ~/.nix-profile/bin/libreoffice --base &";

  # nvim
  nv = "nvim-starter default";
  nvs = "nvim-starter";
  nvp = "NVIM_APPNAME=nvim-playground nvim";
  nvc = "NVIM_APPNAME=nvim-custom nvim";
  nvl = "NVIM_APPNAME=lazyvim nvim";
  nvr = "NVIM_APPNAME=nvim-rolling nvim";
}

