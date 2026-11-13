{ config, lib, ...}:
{

config = lib.mkIf config.my.dolphin.enable
{
	my.umbriel.settings.general.autostart = [ "kbuildsycoca6" ];
};

}