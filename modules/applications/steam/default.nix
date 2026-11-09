{ config, lib, inputs, pkgs, pkgsOld, ... }:
{

options.my.steam.enable = lib.mkEnableOption "Enable Steam";

config = lib.mkIf config.my.steam.enable
{
	nixpkgs.overlays = [ inputs.millennium.overlays.default ];

	my.symlinks =
	[
		{
			source = "/data/appdata/Millennium/plugins";
			destination = ".local/share/millennium/plugins";
		}
		{
			source = "/data/appdata/Millennium/themes";
			destination = ".local/share/Steam/millennium/themes";
		}
		{
			source = "/data/appdata/Millennium/config";
			destination = ".config/millennium";
		}
	];

	programs.steam =
	{
		enable = true;
		package = pkgs.millennium-steam;
		extraCompatPackages = [ pkgsOld.proton-ge-bin ];
	};
};

}