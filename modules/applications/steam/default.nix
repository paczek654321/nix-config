{ config, lib, inputs, pkgs, pkgsOld, ... }:
{

options.my.steam.enable = lib.mkEnableOption "Enable Steam";

config = lib.mkIf config.my.steam.enable
{
	nixpkgs.overlays = [ inputs.millennium.overlays.default ];

	home-manager.users."${config.my.user.username}" = hm:
	let
		mkOutOfStoreSymlink = hm.config.lib.file.mkOutOfStoreSymlink;
	in
	{
		home.file =
		{
			".local/share/millennium/plugins".source = mkOutOfStoreSymlink "/data/appdata/Millennium/plugins";
			".local/share/Steam/millennium/themes".source = mkOutOfStoreSymlink "/data/appdata/Millennium/themes";
			".config/millennium".source = mkOutOfStoreSymlink "/data/appdata/Millennium/config";
		};
	};

	programs.steam =
	{
		enable = true;
		package = pkgs.millennium-steam;
		extraCompatPackages = [ pkgsOld.proton-ge-bin ];
	};
};

}