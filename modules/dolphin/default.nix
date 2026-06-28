{ config, lib, pkgs, ...}:
{

options.my.dolphin.enable = lib.mkEnableOption "Enable dolphin";

config = lib.mkIf config.my.dolphin.enable
{
	home-manager.users."${config.my.user.username}" =
	{
		wayland.windowManager.hyprland.settings.exec-once = lib.mkIf config.my.hyprland-de.enable
		[
			"kbuildsycoca6"
		];

		home.packages = with pkgs;
		[
			kdePackages.dolphin
			kdePackages.kde-cli-tools
			kdePackages.kservice
		];
	};
};

}