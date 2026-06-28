{ config, pkgs, lib,  ... }:
let
	username = config.my.user.username;
in
{

imports =
[
	./scripts.nix
	./style.nix
	./bar-modules.nix

	(lib.mkAliasOptionModule [ "my" "waybar" "custom" ] [ "home-manager" "users" username "programs" "waybar" "settings" "mainBar" ] )
];

options.my.waybar =
{
	enable = lib.mkEnableOption "Enable Waybar";
	modules-left = lib.mkOption
	{
		type = lib.types.listOf lib.types.str;
		default = [ ];
		description = "Modules on the left side of the bar";
    };
	modules-center = lib.mkOption
	{
		type = lib.types.listOf lib.types.str;
		default = [ ];
		description = "Modules in the center of the bar";
    };
	modules-right = lib.mkOption
	{
		type = lib.types.listOf lib.types.str;
		default = [ ];
		description = "Modules on the right side of the bar";
    };
};

config = lib.mkIf config.my.waybar.enable
{
	my.ddcci.enable = true;
	users.users."${username}".extraGroups = [ "input" ];
	home-manager.users."${username}" =
	{
		home.packages = with pkgs; [ brightnessctl ];

		wayland.windowManager.hyprland.settings.exec-once = lib.mkIf config.my.hyprland-de.enable ["waybar"];
		programs.waybar =
		{
			enable = true;
			settings.mainBar =
			{
				modules-left = config.my.waybar.modules-left;
				modules-center = config.my.waybar.modules-center;
				modules-right = config.my.waybar.modules-right;
			};
		};
	};
};

}
