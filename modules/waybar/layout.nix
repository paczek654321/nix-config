{ lib, config, ...}:
{

config = lib.mkIf config.my.waybar.enable
{
	my.waybar =
	{
		modules-left =
		[
			"custom/refresh"
			"hyprland/workspaces"
		];
		modules-center =
		[
			"hyprland/window"
		];
		modules-right =
		[
			"keyboard-state"
			"idle_inhibitor"
			"pulseaudio"
			"network"
			"power-profiles-daemon"
			"custom/brightness"
			"clock"
			"tray"
			"custom/poweroff"
			"custom/reboot"
			"custom/logout"
		];
	};
};

}