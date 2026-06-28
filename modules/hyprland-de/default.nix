{ config, pkgs, lib, ... }:
let
	username = config.my.user.username;
in
{

imports =
[
	./hyprland
	./hypr
	./custom

	(lib.mkAliasOptionModule [ "my" "hyprland-de" "settings" ] [ "home-manager" "users" username "wayland" "windowManager" "hyprland" "settings" ] )
];

options.my.hyprland-de.enable = lib.mkEnableOption "Enable Hyprland DE";

config = lib.mkIf config.my.hyprland-de.enable
{
	my.platform-theme.enable = lib.mkDefault true;

	services.displayManager.ly.enable = true;

	services.udisks2.enable = true;

	my.bluetooth.enable = true;
	my.iwd.enable = true;
	
	my.wofi.enable = lib.mkDefault true;
	my.waybar.enable = lib.mkDefault true;

	home-manager.users."${username}".services.swaync.enable = true;
};

}
