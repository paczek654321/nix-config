{ config, lib, pkgs, ...}:
{

options.my.modrinth.enable = lib.mkEnableOption "Enable modrinth";

config = lib.mkIf config.my.modrinth.enable
{
	nixpkgs.overlays = [ (final: prev:
	{
		modrinth-app-unwrapped = prev.modrinth-app-unwrapped.overrideAttrs (old:
		{
			pnpmDeps = old.pnpmDeps.overrideAttrs (pnpmOld:
			{
				env = (pnpmOld.env or {}) //
				{
					npm_config_fetch_retries = "10";
					npm_config_fetch_retry_mintimeout = "20000";
					npm_config_fetch_retry_maxtimeout = "120000";
					npm_config_fetch_timeout = "300000";
				};
			});
		});
	})];

	home-manager.users."${config.my.user.username}".home.packages = [ pkgs.modrinth-app ];
};

}