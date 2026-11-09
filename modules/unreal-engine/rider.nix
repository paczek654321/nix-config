{ lib, config, pkgs, pkgsGit, unrealFHS, ... }:
{

options.my.unreal-engine.IDE.rider = lib.mkEnableOption "Install Rider for UE5";

config = lib.mkIf config.my.unreal-engine.IDE.rider
{
	environment.systemPackages =
	[
		pkgsGit.jetbrains.rider
		(pkgs.makeDesktopItem
		{
			name = "Rider (Unreal Engine)";
			desktopName = "Rider (Unreal Engine)";
			exec = "${unrealFHS}/bin/unreal-env -c rider";
			icon = "rider";
			categories = [ "Development" ];
		})
	];
};

}