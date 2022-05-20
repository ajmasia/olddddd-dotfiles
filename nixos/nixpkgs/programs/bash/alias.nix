import ../../../../commons/alias/commons.nix //
  import ../../../../commons/alias/git.nix //
  import ../../../../commons/alias/docker.nix //
{
  # directories
  mono = "cd ~/projects/genially/mono && gsh shell";
  dev-dv = "cd ~/projects/genially/dev-databases && gsh shell";

  # vpn
  gdev-vpn = "sudo openvpn ~/.config/vpn/genially_dev.ovpn";

  # apps 
  bazecor = "appimage-run ~/.local/share/app-images/Bazecor-0.3.3.AppImage";

}

