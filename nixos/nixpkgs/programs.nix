{ pkgs, builtins }:

let
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
      export PATH="$HOME/.local/bin:$PATH"
      export SLACK_CLI_TOKEN=$(source ~/.env; echo $SLACK_CLI_TOKEN)

      export DIRENV_LOG_FORMAT=
      eval "$(direnv hook bash)"
    '';

    profileExtra = ''
      # Profile extra config
    '';

    historyIgnore = [ "ls" "cd" "exit" ];
    shellOptions = [ "histappend" "checkwinsize" "extglob" "globstar" "checkjobs" "autocd" ];

    sessionVariables = {
      EDITOR = "vim";
    };

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
        WINIT_X11_SCALE_FACTOR = "1.0";
      };

      font = {
        size = 12;

        normal = {
          family = "Hack Nerd Font";
        };
      };

      # colors = {
      #   primary = {
      #     background = "#1a1b26";
      #     foreground = "#a9b1d6";
      #   };
      #   normal = {
      #     black = "#32344a";
      #     red = "#f7768e";
      #     green = "#9ece6a";
      #     yellow = "#e0af68";
      #     blue = "#7aa2f7";
      #     magenta = "#ad8ee6";
      #     cyan = "#ad8ee6";
      #     white = "#787c99";
      #   };
      #   bright = {
      #     black = "#444b6a";
      #     red = "#ff7a93";
      #     green = "#b9f27c";
      #     yellow = "#ff9e64";
      #     blue = "#7da6ff";
      #     magenta = "#bb9af7";
      #     cyan = "#0db9d7";
      #     white = "#acb0d0";
      #   };
      # };

      colors = {
        primary = {
          background = "#282c34";
          foreground = "#c5c8c6";
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
          black = "#dadada";
          blue = "#85befd";
          cyan = "#85befd";
          green = "#87c38a";
          magenta = "#b9b6fc";
          red = "#fd5ff1";
          white = "#e0e0e0";
          yellow = "#ffd7b1";
        };
        bright = {
          black = "#dadada";
          blue = "#96cbfe";
          cyan = "#85befd";
          green = "#94fa36";
          magenta = "#b9b6fc";
          red = "#fd5ff1";
          white = "#e0e0e0";
          yellow = "#f5ffa8";
        };
      };

      window = {
        padding = { x = 4; y = 4; };
      };

      cursor = {
        blink_interval = 750;
        unfocused_hollow = false;

        style = {
          shape = "beam";
          blinking = "always";
        };
      };
    };
  };

  starship = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      add_newline = false;

      line_break = {
        disabled = true;
      };

      nix_shell = {
        style = "bold blue";
        symbol = "❄️ ";
        impure_msg = "[impure](bold red)";
        pure_msg = "[pure](bold green)";
        format = "via [$symbol$state( \($name)\)]($style) ";
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
    theme = "themes/spotlight-dark.rasi";
    extraConfig = {
      "show-icons" = true;
      "icon-theme" = "Papirus";
      "display-drun" = "";
      "drum-display-format" = "{name}";
      "display-history" = false;
      "fullscreen" = false;
      "hide-scrollbar" = false;
      "sidebar-mode" = false;
    };
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
}

