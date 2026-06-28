{ config, lib, ... }:
let
	colorPalette = config.my.platform-theme.colorPalette;
in
{

config = lib.mkIf config.my.hyprland-de.enable
{
	home-manager.users."${config.my.user.username}".wayland.windowManager.hyprland.settings =
	{
		env =
		[
			"QT_QPA_PLATFORM,wayland"
			"QT_QPA_PLATFORMTHEME,qt5ct"
		];
		general =
		{
			gaps_in = 5;
			gaps_out = 20;
			
			border_size = 2;
			"col.active_border" = "rgb(${colorPalette.primaryAccent}) rgb(${colorPalette.secondaryAccent}) 45deg";
			"col.inactive_border" = "rgb(${colorPalette.background})";
			resize_on_border = true;
			
			layout = "dwindle";
		};
		decoration =
		{
			rounding = 10;
			rounding_power = 2;

			shadow = 
			{
				enabled = true;
				range = 4;
				render_power = 3;
				color = "rgba(1a1a1aee)";
			};
			blur =
			{
				enabled = true;
				size = 3;
				passes = 2;

				vibrancy = 0.1696;
			};
		};
		animations =
		{
			enabled = "yes, please :)";
			bezier =
			[
				"easeOutQuint,0.23,1,0.32,1"
				"easeInOutCubic,0.65,0.05,0.36,1"
				"linear,0,0,1,1"
				"almostLinear,0.5,0.5,0.75,1.0"
				"quick,0.15,0,0.1,1"
			];

			animation =
			[
				"global, 1, 10, default"
				"border, 1, 5.39, easeOutQuint"
				"windows, 1, 4.79, easeOutQuint"
				"windowsIn, 1, 4.1, easeOutQuint, popin 87%"
				"windowsOut, 1, 1.49, linear, popin 87%"
				"fadeIn, 1, 1.73, almostLinear"
				"fadeOut, 1, 1.46, almostLinear"
				"fade, 1, 3.03, quick"
				"layers, 1, 3.81, easeOutQuint"
				"layersIn, 1, 4, easeOutQuint, fade"
				"layersOut, 1, 1.5, linear, fade"
				"fadeLayersIn, 1, 1.79, almostLinear"
				"fadeLayersOut, 1, 1.39, almostLinear"
				"workspaces, 1, 1.94, almostLinear, fade"
				"workspacesIn, 1, 1.21, almostLinear, fade"
				"workspacesOut, 1, 1.94, almostLinear, fade"
			];
		};
		dwindle.preserve_split = true;
		master.new_status = "master";
		misc =
		{
			# Set to 0 or 1 to disable the anime mascot wallpapers
			force_default_wallpaper = -1;
			# If true disables the random hyprland logo / anime girl background. :(
			disable_hyprland_logo = false;
		};
		layerrule =
		[
			"match:namespace wofi, blur on"
		];
		windowrule =
		[
			# Ignore maximize requests from all apps. You'll probably like this.
			"match:class = .*, suppress_event = maximize"
			# Fix some dragging issues with XWayland
			{
				name = "fix-xwayland-drags";
				"match:class" = "^$";
				"match:title" = "^$";
				"match:xwayland" = true;
				"match:float" = true;
				"match:fullscreen" = false;
				"match:pin" = false;
				no_focus = true;
			}
			# Custom
			"match:class ^org\.kde\.dolphin$, opacity 0.75 override"
			"tile on, match:title .*Godot.*"
			"tile on, match:class Unity"
			"tile on, match:class steam"
		];
	};
};

}
