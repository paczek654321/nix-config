{ config, lib, pkgs, ... }:
let
	username = config.my.user.username;
in
{

config = lib.mkIf config.my.hyprland.enable
{
	home-manager.users."${username}".home.packages = with pkgs;
	[
		hyprshot
		hyprpicker
	];
	my.hyprland.settings.bind = ["$mainMod, S, exec, hyprshot -z -m region --clipboard-only"];
};

}