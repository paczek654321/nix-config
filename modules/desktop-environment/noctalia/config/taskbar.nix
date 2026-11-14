{ config, lib, ... }:
let
	username = config.my.user.username;
in
{

config =
{
	home-manager.users.${username}.programs.noctalia.settings =
	{
		bar.default =
		{
			border = "surface_container_low";
			capsule_fill = "surface_container_highest";
			
			capsule = true;
			
			concave_edge_corners = false;

			border_width = 2.0;
			capsule_padding = 10.0;
			
			margin_edge = 5;
			margin_ends = 5;
			
			start = [ "workspaces" ];
			center = [ "active_window" ];
			end = [ "tray" "clipboard" "notifications" "volume" "brightness" "battery" "date" "control-center" ];
		};

		control_center =
		{
			show_shortcut_labels = false;
			calendar.show_events_card = false;
		};

		widget =
		{
			battery.peek = true;
			brightness.peek = true;
			date.format = "{:%H:%M %a, %d %b}";
			volume.peek = true;
			workspaces.hide_when_empty = true;
		};

		shell.show_location = false;
	};
};

}