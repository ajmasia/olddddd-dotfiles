{
  # Edit system and user configs
  hme = "nvim ~/.config/nixpkgs";
  sce = "nvim /etc/nixos/configuration.nix";
   
  # Switch configurations
  hms = "home-manager switch";
  scw = "sudo nixos-rebuild switch";

  # Shell
  c = "clear";
  cat = "bat";
  ls = "exa";
  tree = "l --tree --color=always";
  gtree = "tree -l --git | less -r";
  sb = "for i in $(seq 1 10); do time zsh -i -c exit; done";
  vim = "nvim";
  hm = "home-manager";

  swd = "cd $(find ~/ -type d -print | fzf)";
}

