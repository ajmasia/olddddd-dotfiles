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

    '' + (readFile ./xdg/bash/functions.bash);

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
    userEmail = "dev@ajmasia.me";
    userName = "Antonio José Masiá";

    extraConfig = {
      # TODO: Add github config to auth with token
      core = {
        excludesfile = "${HOME_PATH}/.gitignore";
      };

      init = {
        defaultBranch = "main";
      };

      credential = {
        helper = "store";
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
        # https://github.com/zatchheems/tokyo-night-alacritty-theme
        primary = {
          background = "#24283b";
          foreground = "#a9b1d6";
        };
        selection = {
          background = "#444444";
          text = "#9ece6a";
        };
        cursor = {
          cursor = "#d0d0d0";
          text = "#151515";
        };
        normal = {
          black = "#32344a";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#ad8ee6";
          cyan = "#449dab";
          white = "#9699a8";
        };
        bright = {
          black = "#444b6a";
          red = "#ff7a93";
          green = "#b9f27c";
          yellow = "#ff9e64";
          blue = "#7da6ff";
          magenta = "#bb9af7";
          cyan = "#0db9d7";
          white = "#acb0d0";
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
    enable = true;

    package = unstable.kitty;

    theme = "Tokyo Night Storm";
    settings = {
      font_family = "Hack Nerd Font Regular";
      font_size = 13;
      font_bold = "auto";
      font_italic = "auto";
      font_italic_bold = "auto";
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

  /* eww = { */
  /*   enable = true; */
  /*   configDir = ./xdg/eww; */
  /* }; */
  qutebrowser = {
    enable = true;
  };

  readline = {
    enable = true;

    bindings = {
      "\\e[A" = "history-search-backward"; # arrow up
      "\\e[B" = "history-search-forward"; # arrow down
    };

    variables = {
      editing-mode = "vi";
      show-mode-in-prompt = true;
      vi-cmd-mode-string = "\\1\\e[38;5;214m\\2󰈈 \\1\\e[0m\\2";
      vi-ins-mode-string = "\\1\\e[38;5;46m\\2󰘎 \\1\\e[0m\\2";
    };
  };
}

