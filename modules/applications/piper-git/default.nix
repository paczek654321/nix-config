{ config, lib, pkgs, ...}:
{

options.my.piper-git.enable = lib.mkEnableOption "Enable piper-git";

config = lib.mkIf config.my.piper-git.enable
{
	services.ratbagd =
	{
		enable = true;
		package = pkgs.libratbag-git;
	};
	environment.systemPackages = [ pkgs.piper-git ];
};

}