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
];

config = lib.mkIf config.my.hyprland-de.enable
{
	programs.hyprland.enable = true;

	home-manager.users."${username}" =
	{
		wayland.windowManager.hyprland =
		{
			enable = true;
			configType = "hyprlang"; # Reference for migration to lua: https://git.aquaticservers.com/aqua/AquaticOS/commit/1622b14151e13b94f2d1f81b9e8a3841098eb1cf
			# Fix ly not starting graphical-session.target
			systemd.enable = true;

			package = null;
    		portalPackage = null;
		};
	};
};

}
