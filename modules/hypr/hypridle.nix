{ config, lib, pkgs, ... }:
{

config = lib.mkIf config.my.hyprland.enable
{
	my.ddcci.enable = true;
	security.pam.services.hyprlock = {};
	home-manager.users."${config.my.user.username}" =
	{
		home.packages = with pkgs; [ libnotify ];
		services.hypridle =
		{
			enable = true;
			settings =
			{
				general =
				{
					lock_cmd = "pidof hyprlock || hyprlock";
				};
				listener =
				[
					{
						timeout = 120;
						on-timeout = "notify-send --icon application-exit \"Idle, locking in 20s\"";
						on-resume = "notify-send --icon application-exit \"Resumed\"";
					}
					{
						timeout = 140;
						on-timeout = "loginctl lock-session";
					}
					{
						timeout = 200;
						on-timeout = "hyprctl dispatch dpms off; bash -c 'while (ddcutil detect | grep \"VCP version\" | read); do ddcutil setvcp D6 05; done'";
    					on-resume = "hyprctl dispatch dpms on";
					}
				];
			};
		};
	};
};
}
