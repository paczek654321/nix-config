{ config, lib, ... }:
let
	username = config.my.user.username;
in
{

config =
{
	home-manager.users.${username}.programs.noctalia.settings =
	{
		desktop_widgets.enabled = false;

		shell =
		{
			avatar_path = "/data/other/pics/av&ico/av.png";
			font_family = "Adwaita Sans";
			settings_window_translucent = true;
			launcher =
			{
				category_icons_only = true;
				layout = "simple";
			};
			panel =
			{
				open_near_click_control_center = true;
				transparency_mode = "soft";
			};
		};

		theme =
		{
			builtin = "Noctalia";
			mode = "dark";
			source = "wallpaper";
			wallpaper_scheme = "vibrant";
			templates =
			{
				builtin_ids = [ "gtk3" "gtk4" "kcolorscheme" "qt" "umbriel" ];
				community_ids = [ "obsidian" "steam" ];
			};
		};

		wallpaper =
		{
			directory = "/data";
			default.path = "/data/wallpaper.png";
		};
	};
};

}