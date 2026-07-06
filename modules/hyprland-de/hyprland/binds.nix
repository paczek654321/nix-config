{ config, lib, ... }:
{

config = lib.mkIf config.my.hyprland-de.enable
{
	home-manager.users."${config.my.user.username}".wayland.windowManager.hyprland =
	{

		settings =
		{
			"$terminal" = "kitty";
			"$fileManager" = "dolphin";
			"$menu" = "wofi --show drun";
			"$mainMod" = "SUPER";
			bind =
			[
				"$mainMod, 2, exec, $terminal"
				"$mainMod, Q, killactive,"
				"$mainMod, E, exec, $fileManager"
				"$mainMod, V, togglefloating,"
				"$mainMod, 1, exec, $menu"
				"$mainMod, P, pseudo,"
				"$mainMod, mouse:274, layoutmsg, togglesplit"
				# Move focus with mainMod + arrow keys
				"$mainMod, left, movefocus, l"
				"$mainMod, right, movefocus, r"
				"$mainMod, up, movefocus, u"
				"$mainMod, down, movefocus, d"
			];
			bindm =
			[
				# Move/resize windows with mainMod + LMB/RMB and dragging
				"$mainMod, mouse:272, movewindow"
				"$mainMod, mouse:273, resizewindow"
			];
			bindel =
			[
				# Laptop multimedia keys for volume and LCD brightness
				",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
				",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
				",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
				",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
				",XF86MonBrightnessUp, exec, brightnessctl s 5%+"
				",XF86MonBrightnessDown, exec, brightnessctl s 5%-"
			];
			bindl =
			[
				# Requires playerctl	
				", XF86AudioNext, exec, playerctl next"
				", XF86AudioPause, exec, playerctl play-pause"
				", XF86AudioPlay, exec, playerctl play-pause"
				", XF86AudioPrev, exec, playerctl previous"
			];
			bindru = ["SUPER, SUPER_L, submap, reset"];
		};
		# Disable all binds
		submaps.ignore.settings.bindu = ["$mainMod, grave, submap, ignore"];
	};
};

}
