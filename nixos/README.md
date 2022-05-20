<p align="center">
  <a href="http://github.com/kamranahmedse/developer-roadmap">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/NixOS_logo.svg/640px-NixOS_logo.svg.png" alt="Developer Roadmap" weight="96">
  </a>
  <h2 align="center">System configuration</h2>
</p>

# Directory structure

- `/system` contains the system config. This directory must be linked with your `/etc/nixos` path using a synbolic link.
- `/nixpkgs` contains all the defined user config using `home-manager`. This directory must be linked to `~/.config/nixpkgs` user directory.
