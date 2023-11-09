{
  services.logind.extraConfig = ''
    IdleAction=suspend
    IdleActionSec=10min
  '';
  users.mutableUsers = false;
  users.users = {
    default = {
      name = "name_snrl";
      hashedPassword =
        "$6$6US0iMDXE1K7wj9g$2/JKHfX4VfNETELdt4dTlTUzlmZAmvP4XfRNB5ORVPYNmi6.A4EWpSXkpx/5PrPx1J/LaA41n2NDss/R0Utqh/";
      isNormalUser = true;
      extraGroups = [ "wheel" "dialout" ];
    };
    root.hashedPassword =
      "$6$68YTRwVh7sUS1onf$VwXU4CSQ9/RbbERzYV8TNtfNM8eraZarUZ4oyxXhXHu1j/4ItbSAhuUkkzfc7FF0XKChZnn.hPisvojMSUfM81";
  };
}
