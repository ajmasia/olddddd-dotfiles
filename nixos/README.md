<p align="center">
  <a href="http://github.com/kamranahmedse/developer-roadmap">
    <img src="https://w7.pngwing.com/pngs/750/566/png-transparent-nix-package-manager-nixos-linux-distribution-gnu-guix-logo-watercolor-blue-angle-text-thumbnail.png" alt="Developer Roadmap" weight="96">
  </a>
  <h2 align="center">NixOS</h2>
  <p align="center">System config</p>
</p>

# Directory structure

- `/system` contains the system config. This directory must be linked with your `/etc/nixos` path using a synbolic link.
- `/nixpkgs` contains all the defined user config using `home-manager`. This directory must be linked to `~/.config/nixpkgs` user directory.
