{ config, lib, ...}:
{

options.my.easyeffects.enable = lib.mkEnableOption "Enable easyeffects";

config = lib.mkIf config.my.easyeffects.enable
{
	home-manager.users."${config.my.user.username}".services.easyeffects.enable = true;
};

}