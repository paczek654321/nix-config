{ config, lib, pkgs, ...}:
let
	colorPalette = config.my.platform-theme.colorPalette;
in
{

options.my.easyeffects.enable = lib.mkEnableOption "Enable easyeffects";

config = lib.mkIf config.my.easyeffects.enable
{
	home-manager.users."${config.my.user.username}".services.easyeffects.enable = true;
};

}