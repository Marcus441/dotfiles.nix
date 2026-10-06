{config, ...}: let
  inherit (config.meta) user;
in {
  flake.modules.homeManager.zsh = {config, ...}: let
    inherit (config.desktop) colors16 colorsRgb;
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
        highlight = "fg=${colors16.base03}";
      };

      localVariables.ZSH_AUTOSUGGEST_MANUAL_REBIND = 1;

      syntaxHighlighting = {
        enable = true;
        styles = let
          command = "fg=${colors16.base0B}";
          string = "fg=${colors16.base0A}";
          substitution = "fg=${colors16.base0C}";
          filepath = "fg=${colors16.base0D}";
          plain = "fg=${colors16.base05}";
        in {
          default = plain;
          unknown-token = "fg=${colors16.base08}";
          reserved-word = "fg=${colors16.base0E}";
          comment = "fg=${colors16.base03}";

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
          globbing = "fg=${colors16.base09}";
          history-expansion = "fg=${colors16.base0E}";

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

        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS} 'ma=48;2;${colorsRgb.base02};38;2;${colorsRgb.base06}'
        zstyle ':completion:*:descriptions' format '%F{${colors16.base0C}}%d%f'
        zstyle ':completion:*:messages' format '%F{${colors16.base03}}%d%f'
        zstyle ':completion:*:warnings' format '%F{${colors16.base08}}no matches%f'

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
