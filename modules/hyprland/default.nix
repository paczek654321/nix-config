{ config, pkgs, lib, ... }:
let
	username = config.my.user.username;
in
{

imports =
[
	./workspaces.nix
	./visual.nix
	./input.nix
	./binds.nix
	./xdgmenu.nix
	./xdg-desktop-portal.nix

	(lib.mkAliasOptionModule [ "my" "hyprland" "settings" ] [ "home-manager" "users" username "wayland" "windowManager" "hyprland" "settings" ] )
];

options.my.hyprland.enable = lib.mkEnableOption "Enable Hyprland";

config = lib.mkIf config.my.hyprland.enable
{
	programs.hyprland.enable = true;

	home-manager.users."${username}" =
	{
		wayland.windowManager.hyprland =
		{
			enable = true;
			configType = "hyprlang"; # Reference for migration to lua: https://git.aquaticservers.com/aqua/AquaticOS/commit/1622b14151e13b94f2d1f81b9e8a3841098eb1cf

			systemd.enable = true; # Fix ly not starting graphical-session.target

			package = null;
    		portalPackage = null;
		};
	};
};

}
