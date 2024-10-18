{ pkgs, ... }:
{
  xdg.configFile."stylua/stylua.toml".source = (pkgs.formats.toml { }).generate "stylua.toml" {
    column_width = 100;
    line_endings = "Unix";
    indent_type = "Spaces";
    indent_width = 2;
    quote_style = "AutoPreferSingle";
    call_parentheses = "None";
  };
}
