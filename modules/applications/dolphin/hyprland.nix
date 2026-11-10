{ config, lib, ...}:
{

config = lib.mkIf (config.my.dolphin.enable && config.my.hyprland.enable)
{
	my.hyprland.settings.exec-once = [ "kbuildsycoca6" ];
};

}