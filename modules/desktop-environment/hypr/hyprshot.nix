{ config, lib, pkgs, ... }:
{

config = lib.mkIf config.my.hyprland.enable
{
	environment.systemPackages = with pkgs;
	[
		hyprshot
		hyprpicker
	];
	my.hyprland.settings.bind = ["$mainMod, S, exec, hyprshot -z -m region --clipboard-only"];
};

}