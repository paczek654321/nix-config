{ config, lib, ... }:
{

config = lib.mkIf config.my.hyprpicker.enable
{
	my.umbriel.settings.keybinds."Mod+2" = "spawn kitty";
};

}