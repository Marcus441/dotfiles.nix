_: {
  flake.modules.homeManager.core = {
    config,
    lib,
    pkgs,
    ...
  }: {
    programs.btop = {
      enable = true;
      themes.terminal = with config.terminal.colors; ''
        theme[main_bg]="${background}"
        theme[main_fg]="${foreground}"
        theme[title]="${foreground}"
        theme[hi_fg]="${red}"
        theme[selected_bg]="${selectionBackground}"
        theme[selected_fg]="${yellow}"
        theme[inactive_fg]="${brightBlack}"
        theme[graph_text]="${white}"
        theme[meter_bg]="${brightBlack}"
        theme[proc_misc]="${cyan}"
        theme[cpu_box]="${brightBlack}"
        theme[mem_box]="${brightBlack}"
        theme[net_box]="${brightBlack}"
        theme[proc_box]="${brightBlack}"
        theme[div_line]="${brightBlack}"
        theme[temp_start]="${green}"
        theme[temp_mid]="${yellow}"
        theme[temp_end]="${red}"
        theme[cpu_start]="${green}"
        theme[cpu_mid]="${yellow}"
        theme[cpu_end]="${red}"
        theme[free_start]="${green}"
        theme[free_mid]="${green}"
        theme[free_end]="${brightGreen}"
        theme[cached_start]="${blue}"
        theme[cached_mid]="${blue}"
        theme[cached_end]="${brightBlue}"
        theme[available_start]="${cyan}"
        theme[available_mid]="${cyan}"
        theme[available_end]="${brightCyan}"
        theme[used_start]="${yellow}"
        theme[used_mid]="${brightYellow}"
        theme[used_end]="${red}"
        theme[download_start]="${blue}"
        theme[download_mid]="${cyan}"
        theme[download_end]="${brightCyan}"
        theme[upload_start]="${magenta}"
        theme[upload_mid]="${brightYellow}"
        theme[upload_end]="${red}"
        theme[process_start]="${green}"
        theme[process_mid]="${yellow}"
        theme[process_end]="${red}"
      '';
      package = lib.mkIf pkgs.stdenv.hostPlatform.isLinux (pkgs.btop.override {
        rocmSupport = true;
        cudaSupport = true;
      });
      settings = {
        color_theme = "terminal";
        cpu_sensor = "auto";
        io_graph_combined = false;
        io_mode = true;
        only_physical = true;
        proc_tree = true;
        rounded_corners = false;
        show_coretemp = true;
        show_disks = true;
        show_gpu_info = "on";
        show_uptime = true;
        update_ms = 500;
        truecolor = true;
        graph_symbol = "braille";
        vim_keys = true;
      };
    };
  };
}
