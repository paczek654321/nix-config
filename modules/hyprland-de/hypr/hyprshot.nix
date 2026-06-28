{ config, lib, pkgs, ... }:
let
	username = config.my.user.username;
in
{

config = lib.mkIf config.my.hyprland-de.enable
{
	home-manager.users."${username}".home.packages = with pkgs;
	[
		hyprshot
		hyprpicker
	];
	my.hyprland-de.settings.bind = ["$mainMod, S, exec, hyprshot -z -m region --clipboard-only"];
};

}