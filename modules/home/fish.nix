{ pkgs, ... }: {
  users.defaultUserShell = pkgs.fish;
  environment.systemPackages = with pkgs.fishPlugins; [ autopair-fish ];
  programs.fish = {
    enable = true;
    interactiveShellInit = with pkgs; ''
      stty -ixon # disable flow control
      set -U fish_greeting # disable greeting
      ${coreutils}/bin/dircolors -c | source
      ${zoxide}/bin/zoxide init --cmd j fish | source
      function man; ${page}/bin/page -W "man://$argv[-1]($argv[-2])"; end

      # Nix tricks
      function njump;   cd $(string split -f1-4 / (nwhich $argv) | string join /); end
      function nwhich;  ${coreutils}/bin/readlink -f (${which}/bin/which $argv); end
      complete -c njump   -fa "(__fish_complete_command)"
      complete -c nwhich  -fa "(__fish_complete_command)"

      # colors
      set fish_pager_color_prefix cyan --bold
    '';
  };
}
