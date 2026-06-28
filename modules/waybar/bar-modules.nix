{ config, lib, pkgs, ... }:
{

config = lib.mkIf config.my.waybar.enable
{
	home-manager.users."${config.my.user.username}".programs.waybar.settings.mainBar =
	{
		margin = "5 10 0 10";
		spacing = 10;
		"hyprland/workspaces" =
		{
			active-only = false;
			format = "{icon}";
			format-icons =
			{
				"1" = "󰲡"; "2" = "󰲡";
				"3" = "󰲣"; "4" = "󰲣";
				"5" = "󰲥"; "6" = "󰲥";
				"7" = "󰲧"; "8" = "󰲧";
				"9" = "󰲩"; "10" = "󰲩";
				"11" = "󰲫"; "12" = "󰲫";
				"13" = "󰲭"; "14" = "󰲭";
				"15" = "󰲯"; "16" = "󰲯";
				"17" = "󰲱"; "18" = "󰲱";
				"19" = "󰿭"; "20" = "󰿭";
				"default" = "";
			};
		};
		keyboard-state =
		{
			numlock = false;
			capslock = true;
			format = "{icon}";
			format-icons =
			{
				locked = "󰬈";
				unlocked = "󰯫";
			};
		};
		idle_inhibitor =
		{
			format = "{icon}";
			format-icons =
			{
				activated = "";
				deactivated = "";
			};
		};
		tray =
		{
			icon-size = 21;
			spacing = 10;
		};
		clock =
		{
			tooltip-format = "{:%d} {calendar}";
		};
		cpu =
		{
			format = "{usage}% ";
			tooltip = false;
		};
		memory =
		{
			format = "{}% ";
		};
		power-profiles-daemon =
		{
			format = "{icon}";
			tooltip-format = "Power profile: {profile}\nDriver: {driver}";
			tooltip = true;
			format-icons =
			{
				default = "";
				performance = "";
				balanced = "";
				power-saver = "";
			};
		};
		network =
		{
			format-wifi = "{essid} ({signalStrength}%) ";
			format-ethernet = "{ipaddr}/{cidr} ";
			tooltip = false;
			format-linked = "{ifname} (No IP) ";
			format-disconnected = "Disconnected ⚠";
			on-click = "wofi_wifi.sh";
			on-click-right = "iwctl station wlan0 disconnect";
		};
		pulseaudio =
		{
			format = "{volume}% {icon} {format_source}";
			format-bluetooth = "{volume}% {icon}  {format_source}";
			format-bluetooth-muted = "󰝟 {icon}  {format_source}";
			format-muted = "󰝟 {format_source}";
			format-source = "{volume}% ";
			format-source-muted = "";
			format-icons =
			{
				headphone = "";
				hands-free = "󰋐";
				headset = "󰋎";
				phone = "";
				portable = "";
				car = "";
				default =
				[
					""
					""
					""
				];
			};
			on-click = "pavucontrol";
		};
		"custom/poweroff" =
		{
			format = "󰐥";
			tooltip = false;
			on-click = "systemctl poweroff";
		};
		"custom/reboot" =
		{
			format = "";
			tooltip = false;
			on-click = "reboot";
		};
		"custom/logout" =
		{
			format = "󰍃";
			tooltip = false;
			on-click = "killall wl-clip-persist; hyprctl dispatch exit";
		};
		"custom/refresh" =
		{
			format = "";
			tooltip = false;
			on-click = "killall -r waybar&&waybar";
		};
		"custom/brightness" =
		{
			format = "{text}󰃠";
			tooltip = false;
			exec = "brightnessctl -d $(focused_backlight) get";
			on-scroll-up = "brightnessctl -d $(focused_backlight) set 5%+";
    		on-scroll-down = "brightnessctl -d $(focused_backlight) set 5%-";
			exec-on-event = true;
			interval = "once";
		};
	};
};

}