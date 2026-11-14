{ config, lib, ... }:
let
	username = config.my.user.username;
in
{

config =
{
	home-manager.users.${username}.programs.noctalia.settings =
	{
		idle =
		{
			behavior_order = [ "lock" "screen-off" "lock-and-suspend" ];
			pre_action_fade_seconds = 5;
			behavior =
			{
				lock =
				{
					action = "lock";
					enabled = true;
					timeout = 120.0;
				};
				screen-off =
				{
					action = "screen_off";
					enabled = true;
					timeout = 200.0;
				};
				lock-and-suspend =
				{
					action = "lock_and_suspend";
					enabled = false;
					timeout = 300.0;
				};
			};
		};
	};
};

}