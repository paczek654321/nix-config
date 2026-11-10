{ config, lib, pkgs, ...}:
{

options.my.dolphin.enable = lib.mkEnableOption "Enable dolphin";

config = lib.mkIf config.my.dolphin.enable
{
	services.udisks2.enable = true;

	environment.systemPackages = with pkgs;
	[
		kdePackages.dolphin
		kdePackages.kde-cli-tools
		kdePackages.kservice
		kdePackages.kio
		kdePackages.kio-extras
		kdePackages.kio-fuse
		kdePackages.kded
		kdePackages.plasma-workspace
	];
};

}