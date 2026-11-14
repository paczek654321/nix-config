{ config, lib, ... }:
let
	username = config.my.user.username;
	monitors = builtins.attrNames config.my.umbriel.output;
in
{

config =
{
	home-manager.users.${username}.programs.noctalia.settings =
	{
		lockscreen =
		{
			transition = [ "fade" ];
			transition_duration = 500;
		};

		lockscreen_widgets =
		{
			enabled = true;
			schema_version = 2;
			grid =
			{
				cell_size = 16;
				major_interval = 4;
				visible = true;
			};

			widget = builtins.foldl' (acc: monitor: acc //
			{
				"lockscreen-login-box@${monitor}" =
				{
					box_height = 70.0;
					box_width = 400.0;
					cx = 1280.0;
					cy = 735.0;
					output = monitor;
					placement_height = 1440.0;
					placement_width = 2560.0;
					rotation = 0.0;
					type = "login_box";
					settings =
					{
						background_color = "surface_container";
						background_opacity = 0.5;
						background_radius = 12.0;
						center_password_text = false;
						input_opacity = 1.0;
						input_radius = 6.0;
						layout = "compact";
						show_caps_lock = true;
						show_keyboard_layout = true;
						show_login_button = true;
						show_media = false;
						show_media_controls = true;
						show_password_reveal = true;
						show_session_buttons = true;
						show_unlock_hint = false;
						show_weather = false;
					};
				};

				"clock@${monitor}" =
				{
					box_height = 0.0;
					box_width = 0.0;
					cx = 1280.0;
					cy = 640.0;
					output = monitor;
					placement_height = 1440.0;
					placement_width = 2560.0;
					rotation = 0.0;
					type = "clock";
					settings = {
						background = true;
						background_opacity = 0.5;
						color = "primary";
					};
				};
			}) {} monitors;
		};
	};
};

}