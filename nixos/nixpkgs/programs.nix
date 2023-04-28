{ pkgs, lib, builtins }:

let
  unstable = import <unstable> { };
  HOME_PATH = builtins.getEnv "HOME";
in
with builtins; {
  home-manager = {
    enable = false;
  };

  bash = {
    enable = true;

    initExtra = ''
      # Init extra config
      # Enable vim for the command line
      set -o vi
      # PATH=~/.emacs.d/bin:$PATH
      export PATH="$HOME/.local/bin:$PATH"
      export SLACK_CLI_TOKEN=$(source ~/.env; echo $SLACK_CLI_TOKEN)
      export EDITOR="vim"

      export DIRENV_LOG_FORMAT=
      eval "$(direnv hook bash)"

      # Greet with some fortune cookie | with lovely colors
      fortune | lolcat
    '';

    profileExtra = ''
      # Profile extra config
    '';

    historyIgnore = [ "ls" "cd" "exit" ];
    shellOptions = [ "histappend" "checkwinsize" "extglob" "globstar" "checkjobs" "autocd" ];

    # sessionVariables = {
    #   EDITOR = "nvim";
    # };

    shellAliases = import ./programs/bash/alias.nix;
  };

  git = {
    enable = true;
    userEmail = "email@antoniomasia.com";
    userName = "Antonio José Masiá";

    extraConfig = {
      # TODO: Add github config to auth with token
      core = {
        excludesfile = "${HOME_PATH}/.gitignore";
      };

      init = {
        defaultBranch = "main";
      };

      ui = {
        color = true;
      };
    };

    ignores = [
      ".dir-locals.el"
      ".projectile"
      "TAGS"
      ".tern-project"
      "tsserver.log"
      "ti-.*.log"
      ".log"
    ];
  };

  alacritty = {
    enable = true;

    settings = {
      env = {
        WINIT_X11_SCALE_FACTOR = "1.05";
        # don't work fine with neovim
        # TERM = "xterm-256color";
      };

      class = {
        instance = "Alacritty";
        general = "Alacritty";
      };

      font = {
        size = 12;

        normal = {
          family = "Hack Nerd Font";
        };
      };

      colors = {
        primary = {
          background = "#24283b";
          foreground = "#a9b1d6";
        };
        selection = {
          background = "#444444";
          text = "#c5c8c6";
        };
        cursor = {
          cursor = "#d0d0d0";
          text = "#151515";
        };
        normal = {
          black = "#ad8ee6";
          blue = "#7aa2f7";
          cyan = "#449dab";
          green = "#9ece6a";
          magenta = "#ad8ee6";
          red = "#f7768e";
          white = "#787c99";
          yellow = "#e0af68";
        };
        bright = {
          black = "#bb9af7";
          blue = "#7da6ff";
          cyan = "#bb9af7";
          green = "#b9f27c";
          magenta = "#bb9af7";
          red = "#ff7a93";
          white = "#acb0d0";
          yellow = "#ff9e64";
        };
      };

      window = {
        padding = { x = 8; y = 8; };
      };

      cursor = {
        blink_interval = 750;
        unfocused_hollow = false;

        style = {
          shape = "underline";
          blinking = "always";
        };
      };
      shell = {
        program = "/run/current-system/sw/bin/bash";
      };
    };
  };

  starship = {
    enable = true;

    package = unstable.starship;
    
    enableBashIntegration = true;

    settings = {
      add_newline = false;

      format = "$os$all";

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      os = { 
        disabled = false;
        style = "bold fg:#7AACD7";
        symbols = {
          NixOS = " ";
        };
      };

      username = {
        disabled = true;
        style_user = "green";
        style_root = "red";
        format = "\\[[$user]($style)";
        show_always = true;
      };

      hostname = {
        disabled = true;
        style = "green";
        format = "[@](white)[$hostname]($style)\\] ";
        ssh_only = false;
      };

      line_break = {
        disabled = true;
      };

      aws = {
        disabled = true;
      };

      nodejs = {
        format = "[ $version]($style) ";
        style = "bold green";
      };

      nix_shell = {
        impure_msg = "[impure](red)";
        pure_msg = "[pure](green)";
        format = "on [$state (\\($name\\))shell]($style) ";
        style = "bold fg:#7AACD7";
      };

      git_branch = {
        symbol = "[]($style) ";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
      };

      lua = {
        format = "[$symbol $version]($style) ";
        style = "bold blue";
        symbol = "󰢱";
      };
    };
  };

  tmux = {
    baseIndex = 1;
    enable = true;
    extraConfig = builtins.readFile ../../commons/tmux/tmux.conf;
    historyLimit = 10000;
    keyMode = "vi";
    shortcut = "x";
    terminal = "screen-256color";
  };

  bat = {
    enable = true;
  };

  zathura = {
    enable = true;
    extraConfig = ''
      set selection-clipboard clipboard
    '';
  };

  rofi = {
    enable = true;
    theme = "launcher.rasi";
    # extraConfig = {
    #   "show-icons" = true;
    #   "icon-theme" = "Papirus";
    #   "display-drun" = "";
    #   "drum-display-format" = "{name}";
    #   "display-history" = false;
    #   "fullscreen" = false;
    #   "hide-scrollbar" = false;
    #   "sidebar-mode" = false;
    # };
  };

  vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      ale
      awesome-vim-colorschemes
      ctrlp
      emmet-vim
      fugitive
      nerdtree
      vim-airline
      vim-airline-themes
      vim-css-color
      vim-devicons
      vim-gitgutter
      vim-jsx-pretty
      vim-one
      vim-surround
    ];

    settings = {
      expandtab = true;
      number = true;
      relativenumber = true;
      tabstop = 2;
    };

    extraConfig = ''
      set smarttab
      set softtabstop=0
      set shiftwidth=2
      set autoindent
      set showcmd

      let b:ale_fixers = ['prettier', 'eslint']
      let g:ale_completion_enabled = 1

      set omnifunc=ale#completion#OmniFunc
      let g:ale_completion_autoimport = 1

      let g:airline_theme='fruit_punch'
      let g:airline_powerline_fonts = 1
      colorscheme OceanicNext
    '';
  };

  kitty = {
    enable = false;

    theme = "Tokyo Night Storm";
    settings = {
      font_family = "Hack Nerd Font";
      font_size = 13;
      window_padding_width = 6;
      window_border_width = 0;
      placement_strategy = "center";
      cursor_shape = "underline";
      window_resize_step_cells = 2;
      confirm_os_window_close = 0;
      shell_integration = "enabled";
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = "yes";
    };
  };

  # mu = {
  #   enable = true;
  # };

  xmobar = {
    enable = false;
    extraConfig = builtins.readFile ./xdg/xmobar/xmobar.hs;
  };

  emacs = {
    enable = false;
  };

  vscode = {
    enable = true;

    package = unstable.vscode;
  };
}

