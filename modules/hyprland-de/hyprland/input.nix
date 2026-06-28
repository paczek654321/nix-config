{ config, lib, ... }:
{

config = lib.mkIf config.my.hyprland-de.enable
{
	home-manager.users."${config.my.user.username}".wayland.windowManager.hyprland.settings.input =
	{
		accel_profile="flat";
		kb_layout = config.my.locale.keymap;
		follow_mouse = 1;
	};
};

}
