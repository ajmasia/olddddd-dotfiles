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

      colors = {
        primary = {
          background = "#282c34";
        };
      };

      window = {
        padding = { x = 3; y = 3; };
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
        impure_msg = "i";
        pure_msg = "p";
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
    theme = "themes/launcher.rasi";
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

