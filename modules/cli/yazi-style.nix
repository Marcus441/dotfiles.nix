_: {
  flake.modules.homeManager.yazi =
    { config, ... }:
    let
      inherit (config.terminal) colors;
    in
    {
      programs.yazi.settings = {
        input = {
          cd_title = " Change directory:";
          create_title = [
            " Create:"
            " Create (dir):"
          ];
          rename_title = " Rename:";
          filter_title = " Filter:";
          find_title = [
            " Find next:"
            " Find previous:"
          ];
          search_title = " Search via {n}:";
          shell_title = [
            " Shell:"
            " Shell (block):"
          ];
        };

        confirm = {
          trash_title = " Trash {n} selected file{s}?";
          delete_title = " Permanently delete {n} selected file{s}?";
          overwrite_title = " Overwrite file?";
          quit_title = " Quit?";
        };

        pick.open_title = " Open with:";
      };

      programs.yazi.theme = {
        mgr = {
          marker_marked = {
            fg = "lightcyan";
            bg = "lightcyan";
          };
          tab_width = 1;
          syntect_theme = "${config.terminal.syntaxTheme}";

          border_style.fg = colors.brightBlack;

          find_keyword = {
            fg = colors.blue;
            bold = true;
            italic = false;
            underline = false;
          };
          find_position = {
            fg = colors.brightMagenta;
            bold = true;
            italic = false;
          };
        };

        confirm = {
          border.fg = colors.brightBlack;

          title = {
            fg = colors.white;
            bold = true;
          };

          btn_yes = {
            fg = colors.brightGreen;
            bold = true;
          };
          btn_no.fg = colors.brightRed;
          btn_labels = [
            "  󰄬 Yes  "
            "  󰅖 No  "
          ];
        };

        cmp = {
          border.fg = colors.brightBlack;

          active = {
            reversed = false;
            bg = colors.selectionBackground;
          };

          icon_file = "󰈔";
          icon_folder = "󰉋";
          icon_command = "󰆍";
        };

        notify = {
          title_info.fg = colors.blue;
          title_warn.fg = colors.brightYellow;
          title_error.fg = colors.brightRed;

          icon_info = "󰋽";
          icon_warn = "󰀪";
          icon_error = "󰅚";
        };

        input = {
          border.fg = colors.brightBlack;

          title = {
            fg = colors.white;
            bold = true;
          };

          selected = {
            reversed = false;
            bg = colors.selectionBackground;
          };
        };

        pick = {
          border.fg = colors.brightBlack;

          active = {
            fg = colors.foreground;
            bg = colors.selectionBackground;
            bold = true;
          };
        };

        spot = {
          border.fg = colors.brightBlack;

          title = {
            fg = colors.white;
            bold = true;
          };
        };

        tasks = {
          border.fg = colors.brightBlack;

          title = {
            fg = colors.white;
            bold = true;
          };

          hovered = {
            fg = colors.foreground;
            bg = colors.selectionBackground;
          };
        };

        help.hovered = {
          reversed = false;
          bg = colors.selectionBackground;
          bold = true;
        };

        indicator = {
          padding = {
            open = "▐";
            close = "▌";
          };

          current = {
            reversed = false;
            bg = colors.selectionBackground;
          };

          parent = {
            reversed = false;
            bg = colors.brightBlack;
          };

          preview = {
            underline = false;
            bg = colors.brightBlack;
          };
        };

        mode = {
          normal_main = {
            fg = colors.background;
            bg = colors.blue;
            bold = true;
          };
          normal_alt = {
            fg = colors.blue;
            bg = colors.background;
          };
          select_main = {
            fg = colors.background;
            bg = colors.green;
            bold = true;
          };
          select_alt = {
            fg = colors.green;
            bg = colors.background;
          };
          unset_main = {
            fg = colors.background;
            bg = colors.red;
            bold = true;
          };
          unset_alt = {
            fg = colors.red;
            bg = colors.background;
          };
        };

        status = {
          sep_left = {
            open = "▐";
            close = "▌";
          };
          sep_right = {
            open = "▐";
            close = "▌";
          };

          progress_normal = {
            fg = colors.blue;
            bg = "reset";
          };
          progress_error = {
            fg = colors.red;
            bg = "reset";
          };
        };

        which = {
          cols = 3;
          separator = "  ";
        };

        icon = {
          dirs = [ ];
          conds = [
            {
              "if" = "orphan";
              text = "";
            }
            {
              "if" = "link";
              text = "";
            }
            {
              "if" = "block";
              text = "";
            }
            {
              "if" = "char";
              text = "";
            }
            {
              "if" = "fifo";
              text = "";
            }
            {
              "if" = "sock";
              text = "";
            }
            {
              "if" = "sticky";
              text = "";
            }
            {
              "if" = "dummy";
              text = "";
            }
            {
              "if" = "dir & hovered";
              text = "";
            }
            {
              "if" = "dir";
              text = "";
            }
            {
              "if" = "exec";
              text = "";
            }
            {
              "if" = "!dir";
              text = "";
            }
          ];
        };
      };
    };
}
