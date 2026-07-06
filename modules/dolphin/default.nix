{ config, lib, pkgs, ...}:
{

options.my.dolphin.enable = lib.mkEnableOption "Enable dolphin";

config = lib.mkIf config.my.dolphin.enable
{
	my.hyprland.settings.exec-once = lib.mkIf config.my.hyprland.enable
	[
		"kbuildsycoca6"
	];
	
	home-manager.users."${config.my.user.username}".home.packages = with pkgs;
	[
		kdePackages.dolphin
		kdePackages.kde-cli-tools
		kdePackages.kservice
	];

	services.udisks2.enable = true;

	environment.systemPackages = with pkgs;
	[
		kdePackages.kio
		kdePackages.kio-extras
		kdePackages.kio-fuse
	];
};

}