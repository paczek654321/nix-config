{ config, lib, pkgs, inputs, ... }:
let
	colorPalette = config.my.platform-theme.colorPalette;
in
{
	imports = [ ./common.nix ];

	networking.hostName = "Hephaestus";

	hardware =
	{
		graphics =
		{
			enable = true;
			enable32Bit = true;
		};
		amdgpu.opencl.enable = true;
		enableRedistributableFirmware = true;
		cpu.amd.updateMicrocode = true;
	};

	boot.kernelPackages = pkgs.linuxPackages_latest;

	nixpkgs.overlays = 
	[
		(final: prev: 
		{
			linux-firmware = inputs.hephaestus-firmware.legacyPackages.${prev.stdenv.hostPlatform.system}.linux-firmware;
		})
	];

	my.ddcci =
	{
		enable = true;
		displayDev = "AMDGPU DM aux hw bus *";
	};

	my.hyprland =
	{
		enable = true;
		workspaces.monitors =
		[
			"DP-1"
			"DP-2"
		];
		settings.monitor =
		[
			"DP-1, highrr, auto-right, 1"
			"DP-2, highrr, auto-left, 1"
			"HDMI-A-1, disable"
		];
	};

	my.waybar =
	{
		custom =
		{
			"custom/tv" =
			{
				tooltip = false;
				exec = "hyprctl monitors | grep HDMI-A-1 | read && echo  || echo 󰻆";
				on-click = "hyprctl keyword monitor \"HDMI-A-1, $(hyprctl monitors | grep HDMI-A-1 | read && echo disable || echo highres, auto-left, 1)\"";
				exec-on-event = true;
				interval = "once";
			};
		};
		modules-right = lib.mkBefore
		[
			"custom/tv"
		];
	};

	my.platform-theme = lib.mkDefault
	{
		icon_theme = "BeautySolar";
		icon_theme_pkg = pkgs.beauty-solar;
		colorPalette =
		{
			ansiiPrimary = "124";
			ansiiSecondary = "198";
			ansiiTertiary = "220";
			ansiiText = "15";
			primaryAccent = "FD4663";
			secondaryAccent = "ff33aa";
			background = "281418";
		};
	};

	my.backups =
	{
		enable = true;
		files =
		[
			{
				source = "/data/appdata/Terraria";
				destination = ".local/share/Terraria";
			}
			{
				source = "/data/appdata/SteamRecordings";
				destination = ".local/share/Steam/userdata/1249129951/gamerecordings";
			}
			{
				source = "/data/appdata/UnityEditor";
				destination = "/home/paczek/Unity/Hub/Editor";
			}
		];
	};

	my.vscodium.workbench.colorTheme = "Sweet Dracula Monokai";
}