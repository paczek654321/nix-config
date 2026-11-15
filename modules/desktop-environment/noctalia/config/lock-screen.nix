{ config, lib, ... }:
let
	username = config.my.user.username;
	monitors = builtins.attrNames config.my.umbriel.output;
	get_dimensions = monitor:
	let
		mode = config.my.umbriel.output.${monitor}.mode;
		dimensions = builtins.match "([0-9]+)x([0-9]+)@.*" mode;
	in
	if dimensions == null then
	{
		width = 0;
		height = 0;
	}
	else
	{
		width = builtins.fromJSON (builtins.elemAt dimensions 0);
		height = builtins.fromJSON (builtins.elemAt dimensions 1);
	};
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

			widget = builtins.foldl' (acc: monitor:
			let
				dimensions = get_dimensions monitor;
			in acc //
			{
				"lockscreen-login-box@${monitor}" =
				{
					box_height = 0.05 * dimensions.height;
					box_width = 0.0;
					cx = 0.5 * dimensions.width;
					cy = 0.55 * dimensions.height;
					output = monitor;
					placement_height = dimensions.height;
					placement_width = dimensions.width;
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
					box_height = 0.05 * dimensions.height;
					box_width = 0.0;
					cx = 0.5 * dimensions.width;
					cy = 0.45 * dimensions.height;
					output = monitor;
					placement_height = dimensions.height;
					placement_width = dimensions.width;
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