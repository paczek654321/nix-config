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
				source = "/data/appdata/UnityEditor";
				destination = "/home/paczek/Unity/Hub/Editor";
			}
		];
	};

	my.vscodium.settings.workbench.colorTheme = "Sweet Dracula Monokai";
}