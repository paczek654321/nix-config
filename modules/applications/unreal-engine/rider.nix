{ lib, config, pkgs, pkgsGit, unrealFHS, ... }:
{

options.my.unreal-engine.IDE.rider = lib.mkEnableOption "Install Rider for UE5";

config = lib.mkIf config.my.unreal-engine.IDE.rider
{
	environment.systemPackages =
	let
		rider = pkgsGit.jetbrains.rider;
	in
	[
		(pkgs.runCommand "rider-icons" {} ''
			mkdir -p $out/share
			ln -s ${rider}/share/icons $out/share/icons
		'')
		(pkgs.makeDesktopItem
		{
			name = "Rider (Unreal Engine)";
			desktopName = "Rider (Unreal Engine)";
			exec = "${unrealFHS}/bin/unreal-env -c ${rider}/bin/rider";
			icon = "rider";
			categories = [ "Development" ];
		})
	];
};

}