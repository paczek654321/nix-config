{ config, lib, pkgs, pkgsGit, ...}:
{

options.my.modrinth.enable = lib.mkEnableOption "Enable modrinth";

config = lib.mkIf config.my.modrinth.enable
{
	nixpkgs.overlays = [ (final: prev:
	{
		modrinth-app-unwrapped = pkgsGit.modrinth-app-unwrapped;
		modrinth-app = pkgsGit.modrinth-app;
	})];

	home-manager.users."${config.my.user.username}".home.packages = [ pkgs.modrinth-app ];
};

}