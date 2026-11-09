{ config, lib, pkgs, ...}:
{

options.my.r2modman.enable = lib.mkEnableOption "Enable r2modman";

config = lib.mkIf config.my.r2modman.enable
{
	my.symlinks =
	[
		{
			source = "/data/appdata/r2modman/config";
			destination = ".config/r2modman";
		}
		{
			source = "/data/appdata/r2modman/games";
			destination = ".config/r2modmanPlus-local";
		}
	];
	environment.systemPackages = with pkgs; [ r2modman ];
};

}