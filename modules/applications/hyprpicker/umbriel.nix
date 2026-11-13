{ config, lib, ... }:
{

config = lib.mkIf config.my.hyprpicker.enable
{
	my.umbriel.settings.keybinds."Mod+Z" = "spawn wl-copy $(hyprpicker)";
};

}
