{ config, lib, ... }:
{

config = lib.mkIf config.my.hyprland.enable
{
	my.hyprland.settings.input =
	{
		accel_profile="flat";
		kb_layout = config.my.locale.keymap;
		follow_mouse = 1;
	};
};

}
