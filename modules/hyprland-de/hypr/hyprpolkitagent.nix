{ config, lib, ... }:
let
	username = config.my.user.username;
in
{

config = lib.mkIf config.my.hyprland-de.enable
{
	security.polkit.enable = true;

	home-manager.users."${username}".services.hyprpolkitagent.enable = true;
};

}
