{ lib, config, pkgs, ... }:
{

options.my.brave.enable = lib.mkEnableOption "Enable Brave browser";

config = lib.mkIf config.my.brave.enable
{
	environment.systemPackages = with pkgs; [ brave ];
	my.symlinks =
	[
		{
			source = "/data/appdata/Brave";
			destination = ".config/BraveSoftware/Brave-Browser";
		}
	];
};

}
