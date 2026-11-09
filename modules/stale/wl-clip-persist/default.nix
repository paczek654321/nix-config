{ config, lib, ... }:
{

options.my.wl-clip-persist.enable = lib.mkEnableOption "Enable wl-clip-persist";

config = lib.mkIf config.my.wl-clip-persist.enable
{
	home-manager.users."${config.my.user.username}".services.wl-clip-persist.enable = true;
};

}
