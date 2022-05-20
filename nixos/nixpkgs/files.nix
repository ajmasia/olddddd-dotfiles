{ ... }:
{
  ".bash_completion".text = builtins.readFile ../../commons/bash/git_completions.sh;
  ".config/rofi/themes".source = ./xdg/rofi;
  ".config/nvim/init.lua".source = ../../commons/nvim/init.lua;
  ".config/nvim/lua".source = ../../commons/nvim/lua;
}

