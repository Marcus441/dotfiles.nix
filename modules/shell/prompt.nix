_: {
  flake.modules.homeManager.core = {
    programs.bash.initExtra = ''
      # OSC 7: report the cwd, so a new window opens in it.
      __osc7_cwd() {
        local LC_ALL=C encoded="" char i
        for (( i = 0; i < ''${#PWD}; i++ )); do
          char=''${PWD:i:1}
          case $char in
            [-/._~A-Za-z0-9]) encoded+=$char ;;
            *) printf -v char '%%%02X' "'$char"; encoded+=$char ;;
          esac
        done
        printf '\e]7;file://%s%s\e\\' "''${HOSTNAME:-$(hostname)}" "$encoded"
      }

      __prompt() {
        __prompt_cwd=''${PWD/#$HOME/\~}
        __prompt_cwd=''${__prompt_cwd//[[:cntrl:]]/?}
      }
      PS1='$__prompt_cwd$ '
      case "$PROMPT_COMMAND" in
        *__prompt*) ;;
        *) PROMPT_COMMAND="__prompt;__osc7_cwd''${PROMPT_COMMAND:+;$PROMPT_COMMAND}" ;;
      esac
    '';
  };

  flake.modules.homeManager.zsh =
    { pkgs, ... }:
    let
      omz = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
      robbyrussell = pkgs.writeTextFile {
        name = "robbyrussell-prompt";
        destination = "/robbyrussell.plugin.zsh";
        text = ''
          autoload -U colors && colors
          setopt prompt_subst
          source ${omz}/lib/async_prompt.zsh
          source ${omz}/lib/git.zsh
          source ${omz}/themes/robbyrussell.zsh-theme
        '';
      };
    in
    {
      programs.zsh.plugins = [
        {
          name = "robbyrussell";
          src = robbyrussell;
        }
      ];

      programs.zsh.initContent = ''
        autoload -Uz add-zsh-hook

        # OSC 7: report the cwd, so a new window opens in it.
        __osc7_cwd() {
          emulate -L zsh -o extended_glob
          local LC_ALL=C
          local encoded=''${PWD//(#m)[^-\/._~A-Za-z0-9]/%''${(l:2::0:)$(( [##16] #MATCH ))}}
          printf '\e]7;file://%s%s\e\\' "$HOST" "$encoded"
        }
        add-zsh-hook precmd __osc7_cwd
      '';
    };
}
