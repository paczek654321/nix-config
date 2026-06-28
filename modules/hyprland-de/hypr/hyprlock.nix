{ config, lib, ... }:
let
	colorPalette = config.my.platform-theme.colorPalette;
in
{

config = lib.mkIf config.my.hyprland-de.enable
{
	security.pam.services.hyprlock = {};
	my.hyprland-de.settings.bind = [ "$mainMod, ESCAPE, exec, hyprlock" ];
	home-manager.users."${config.my.user.username}".programs.hyprlock =
	{
		enable = true;
		settings =
		{
			background =
			{
				monitor = "";
				path = "/data/wallpaper.png";
				blur_passes = 3;
			};
			input-field =
			{
				monitor = "";

				inner_color = "rgb(${colorPalette.background})";
				outer_color = "rgb(${colorPalette.primaryAccent})";
				font_color = "rgb(${colorPalette.primaryAccent})";

				size = "200, 50";
				position = "0, -35";
				halign = "center";
				valign = "center";

				placeholder_text = "";

				outline_thickness = 3;
				dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
				dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
				dots_center = true;
				dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
				rounding = -1; # -1 means complete rounding (circle/oval)
			};
			label =
			{
				monitor = "";

				color = "rgb(${colorPalette.primaryAccent})";

				position = "0, 35";
				halign = "center";
				valign = "center";

				text = "cmd[update:1000] echo \"$TIME\"";

				font_size = 55;
				font_family = "Fira Semibold";
			};
		};
	};
};

}
