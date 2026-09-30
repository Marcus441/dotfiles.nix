_: {
  flake.modules.homeManager.core = {
    config,
    lib,
    pkgs,
    ...
  }: {
    programs.btop = {
      enable = true;
      themes.desktop = with config.desktop.colors; ''
        theme[main_bg]="${base00}"
        theme[main_fg]="${base05}"
        theme[title]="${base05}"
        theme[hi_fg]="${base08}"
        theme[selected_bg]="${base02}"
        theme[selected_fg]="${base0A}"
        theme[inactive_fg]="${base03}"
        theme[graph_text]="${base04}"
        theme[meter_bg]="${base01}"
        theme[proc_misc]="${base0C}"
        theme[cpu_box]="${base03}"
        theme[mem_box]="${base03}"
        theme[net_box]="${base03}"
        theme[proc_box]="${base03}"
        theme[div_line]="${base03}"
        theme[temp_start]="${base0B}"
        theme[temp_mid]="${base0A}"
        theme[temp_end]="${base08}"
        theme[cpu_start]="${base0B}"
        theme[cpu_mid]="${base0A}"
        theme[cpu_end]="${base08}"
        theme[free_start]="${base0B}"
        theme[free_mid]="${base0B}"
        theme[free_end]="${base14}"
        theme[cached_start]="${base0D}"
        theme[cached_mid]="${base0D}"
        theme[cached_end]="${base16}"
        theme[available_start]="${base0C}"
        theme[available_mid]="${base0C}"
        theme[available_end]="${base15}"
        theme[used_start]="${base0A}"
        theme[used_mid]="${base09}"
        theme[used_end]="${base08}"
        theme[download_start]="${base0D}"
        theme[download_mid]="${base0C}"
        theme[download_end]="${base15}"
        theme[upload_start]="${base0E}"
        theme[upload_mid]="${base09}"
        theme[upload_end]="${base08}"
        theme[process_start]="${base0B}"
        theme[process_mid]="${base0A}"
        theme[process_end]="${base08}"
      '';
      package = lib.mkIf pkgs.stdenv.hostPlatform.isLinux (pkgs.btop.override {
        rocmSupport = true;
        cudaSupport = true;
      });
      settings = {
        color_theme = "desktop";
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
