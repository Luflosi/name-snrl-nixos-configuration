{ pkgs, ... }:
{
  programs = {
    direnv.enable = true;
    nix-index = {
      enable = true;
      package = pkgs.nix-index-with-db;
    };
    command-not-found.enable = false;
    htop = {
      enable = true;
      settings = {
        column_meters_0 = "LeftCPUs Blank DateTime Uptime LoadAverage Tasks Blank Swap Memory";
        column_meter_modes_0 = "1 2 2 2 2 2 2 2 2";
        column_meters_1 = "RightCPUs Blank DiskIO NetworkIO";
        column_meter_modes_1 = "1 2 1 1";

        fields = "0 4 48 17 18 50 46 39 2 49 1";
        tree_view = 1;
        tree_sort_key = 39;
        tree_sort_direction = -1;
        hide_kernel_threads = 1;
        hide_userland_threads = 1;
        show_program_path = 0;
        highlight_base_name = 1;
        show_cpu_frequency = 1;
        cpu_count_from_one = 1;
        color_scheme = 6;

        "screen:Mem" = ''
          PID OOM USER M_VIRT M_SHARE M_RESIDENT M_SWAP Command
          .sort_key=M_RESIDENT
          .tree_sort_key=M_RESIDENT
          .tree_view=1
          .sort_direction=-1
          .tree_sort_direction=-1
        '';
      };
    };
  };
}
