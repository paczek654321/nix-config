{ config, lib, pkgs, ...}:
{

options.my.fastfetch.enable = lib.mkEnableOption "Enable fastfetch";

config = lib.mkIf config.my.fastfetch.enable
{
	environment.systemPackages = [ pkgs.fastfetch ];
};

}