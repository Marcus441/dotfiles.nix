{config, ...}: let
  inherit (config.meta) user;
in {
  flake.modules.homeManager.zsh = {config, ...}: let
    inherit (config.terminal) colors colorsRgb;
  in {
    programs.zsh = {
      enable = true;

      dotDir = "${config.xdg.configHome}/zsh";

      defaultKeymap = "emacs";

      shellAliases = {
        nix = "noglob nix";
      };

      history = {
        size = 50000;
        save = 100000;
        path = "${config.xdg.stateHome}/zsh/history";
      };

      autosuggestion = {
        enable = true;
        highlight = "fg=${colors.brightBlack}";
      };

      localVariables.ZSH_AUTOSUGGEST_MANUAL_REBIND = 1;

      syntaxHighlighting = {
        enable = true;
        styles = let
          command = "fg=${colors.green}";
          string = "fg=${colors.yellow}";
          substitution = "fg=${colors.cyan}";
          filepath = "fg=${colors.blue}";
          plain = "fg=${colors.foreground}";
        in {
          default = plain;
          unknown-token = "fg=${colors.red}";
          reserved-word = "fg=${colors.magenta}";
          comment = "fg=${colors.brightBlack}";

          alias = command;
          suffix-alias = command;
          global-alias = command;
          builtin = command;
          function = command;
          inherit command;
          precommand = command;
          hashed-command = command;
          arg0 = command;

          path = filepath;
          path_prefix = filepath;
          autodirectory = filepath;
          globbing = "fg=${colors.brightYellow}";
          history-expansion = "fg=${colors.magenta}";

          single-quoted-argument = string;
          double-quoted-argument = string;
          dollar-quoted-argument = string;
          rc-quote = string;

          dollar-double-quoted-argument = substitution;
          back-double-quoted-argument = substitution;
          back-dollar-quoted-argument = substitution;
          back-quoted-argument = substitution;
          command-substitution-delimiter = substitution;
          process-substitution-delimiter = substitution;
          single-hyphen-option = substitution;
          double-hyphen-option = substitution;

          assign = plain;
          redirection = plain;
          commandseparator = plain;
          named-fd = plain;
          numeric-fd = plain;
        };
      };

      initContent = ''
        setopt extended_glob null_glob interactivecomments

        zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}'
        zstyle ':completion:*' completer _complete _match
        zstyle ':completion:*' menu select
        unsetopt list_ambiguous

        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS} 'ma=48;2;${colorsRgb.selectionBackground};38;2;${colorsRgb.selectionForeground}'
        zstyle ':completion:*:descriptions' format '%F{${colors.cyan}}%d%f'
        zstyle ':completion:*:messages' format '%F{${colors.brightBlack}}%d%f'
        zstyle ':completion:*:warnings' format '%F{${colors.red}}no matches%f'

        [[ -r /etc/zinputrc ]] && source /etc/zinputrc

        autoload -Uz edit-command-line
        zle -N edit-command-line
        bindkey '^X^E' edit-command-line
      '';
    };
  };

  flake.modules.nixos.zsh = {pkgs, ...}: {
    programs.zsh = {
      enable = true;
      promptInit = "";
      enableGlobalCompInit = false;
    };

    users.users.${user}.shell = pkgs.zsh;
  };

  flake.modules.darwin.zsh = {
    programs.zsh = {
      enable = true;
      promptInit = "";
      enableGlobalCompInit = false;
    };
  };
}
