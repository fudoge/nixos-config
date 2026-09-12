{...}: {
  programs = {
    btop = {
      enable = true;
      settings.color_theme = "rose-pine";
      themes.rose-pine = ./rose-pine.theme;
    };

    bottom = {
      enable = true;
      # bottom has no built-in Rosé Pine theme, so map its style roles to the
      # Rosé Pine main palette.
      settings.styles = {
        cpu = {
          all_entry_color = "#9ccfd8";
          avg_entry_color = "#ebbcba";
          cpu_core_colors = [
            "#c4a7e7"
            "#f6c177"
            "#9ccfd8"
            "#31748f"
            "#ebbcba"
            "#eb6f92"
          ];
        };
        memory = {
          ram_color = "#c4a7e7";
          cache_color = "#ebbcba";
          swap_color = "#f6c177";
          arc_color = "#9ccfd8";
          gpu_colors = [
            "#9ccfd8"
            "#eb6f92"
            "#31748f"
            "#f6c177"
            "#c4a7e7"
            "#ebbcba"
          ];
        };
        network = {
          rx_color = "#9ccfd8";
          tx_color = "#ebbcba";
          rx_total_color = "#31748f";
          tx_total_color = "#c4a7e7";
        };
        battery = {
          high_battery_color = "#31748f";
          medium_battery_color = "#f6c177";
          low_battery_color = "#eb6f92";
        };
        tables.headers = {
          color = "#9ccfd8";
          bold = true;
        };
        graphs = {
          graph_color = "#908caa";
          legend_text.color = "#6e6a86";
        };
        widgets = {
          border_color = "#6e6a86";
          selected_border_color = "#c4a7e7";
          widget_title.color = "#908caa";
          text.color = "#e0def4";
          selected_text = {
            color = "#191724";
            bg_color = "#ebbcba";
          };
          disabled_text.color = "#6e6a86";
          thread_text.color = "#31748f";
        };
      };
    };
  };
}
