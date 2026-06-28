{ config, lib, pkgs, ...}:
{

options.my.r2modman.enable = lib.mkEnableOption "Enable r2modman";

config = lib.mkIf config.my.r2modman.enable
{
	home-manager.users."${config.my.user.username}" = hm:
	let
		mkOutOfStoreSymlink = hm.config.lib.file.mkOutOfStoreSymlink;
	in
	{
		home.packages = [ pkgs.r2modman ];
		home.file.".config/r2modman".source = mkOutOfStoreSymlink "/data/appdata/r2modman/config";
		home.file.".config/r2modmanPlus-local".source = mkOutOfStoreSymlink "/data/appdata/r2modman/games";
	};
};

}