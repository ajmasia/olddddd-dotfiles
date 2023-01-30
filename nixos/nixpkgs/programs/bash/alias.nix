import ../../../../commons/alias/commons.nix //
  import ../../../../commons/alias/git.nix //
  import ../../../../commons/alias/docker.nix //
{
  # directories
  gmo = "cd ~/projects/genially/mono && gsh shell";
  gdb = "cd ~/projects/genially/dev-databases && gsh shell";
  doc = "cd ~/synology-drive";

  # vpn
  gdev-vpn = "sudo openvpn ~/.config/vpn/genially_dev.ovpn";

  # apps 
  bazecor = "appimage-run ~/.local/share/app-images/Bazecor-0.3.3.AppImage";

  # genially project
  grp = "yarn clean:modules && yarn && gsh cli builder --all";

  # Programs
  r3t = "nix-shell -p robo3t --run robo3t &";
  calc = "env GTK_THEME=Adwaita ~/.nix-profile/bin/libreoffice --calc &";
  base = "env GTK_THEME=Adwaita ~/.nix-profile/bin/libreoffice --base &";
}

