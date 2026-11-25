{ config, lib, ... }:
{

config = lib.mkIf config.my.fcitx5-mandarin.enable
{
	my.umbriel.settings =
	{
		general.autostart = [ "sleep 1 && fcitx5" ];
		keybinds."Mod+Tab" = "spawn fcitx5-remote -t";
	};
};

}