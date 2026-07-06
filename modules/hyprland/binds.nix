{ config, lib, pkgs, ... }:
{

config = lib.mkIf config.my.hyprland.enable
{
	home-manager.users."${config.my.user.username}".wayland.windowManager.hyprland =
	{
		settings =
		{
			"$mainMod" = "SUPER";
			bind =
			[
				"$mainMod, Q, killactive,"
				
				"$mainMod, V, togglefloating,"
				"$mainMod, mouse:274, layoutmsg, togglesplit"
				
				"$mainMod, left, movefocus, l"
				"$mainMod, right, movefocus, r"
				"$mainMod, up, movefocus, u"
				"$mainMod, down, movefocus, d"
			];
			bindm =
			[
				"$mainMod, mouse:272, movewindow"
				"$mainMod, mouse:273, resizewindow"
			];
			bindru = ["SUPER, SUPER_L, submap, reset"];
		};
		# Disable all binds
		submaps.ignore.settings.bindu = ["$mainMod, grave, submap, ignore"];
	};
};

}
