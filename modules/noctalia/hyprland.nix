{ config, lib, ...}:
{

config = lib.mkIf (config.my.noctalia.enable && config.my.hyprland.enable)
{
	my.hyprland.enableHyprpaper = false;
	my.hyprland.settings =
	{
		bind =
		[
			"$mainMod, 1, exec, noctalia-shell ipc call launcher toggle"
		];

		bindel =
		[
			",XF86AudioRaiseVolume, exec, noctalia-shell ipc call volume increase"
			",XF86AudioLowerVolume, exec, noctalia-shell ipc call volume decrease"
			
			",XF86AudioMute, exec, noctalia-shell ipc call volume muteOutput"
			
			",XF86MonBrightnessUp, exec, noctalia-shell ipc call brightness increase"
			",XF86MonBrightnessDown, exec, noctalia-shell ipc call brightness decrease"
		];

		bindl =
		[
			", XF86AudioNext, exec, noctalia-shell ipc call media next"
			", XF86AudioPause, exec, noctalia-shell ipc call media pause"
			", XF86AudioPlay, exec, noctalia-shell ipc call media play"
			", XF86AudioPrev, exec, noctalia-shell ipc call media previous"
		];
		layerrule =
		[
			{
				name = "noctalia";
				"match:namespace" = "noctalia-background-.*$";
				ignore_alpha = 0.05;
				blur = true;
				blur_popups = true;
			}
		];
	};
};

}