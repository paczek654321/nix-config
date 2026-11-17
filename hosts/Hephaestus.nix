{ config, lib, pkgs, pkgsOld, ... }:
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
			linux-firmware = pkgsOld.linux-firmware;
		})
	];

	my.umbriel.output =
	{
		"DP-1" =
		{
			mode = "2560x1440@165.080";
		};

		"DP-2" =
		{
			mode = "2560x1440@165.080";
			position = [0 0];
		};
	};

	my.platform-theme = lib.mkDefault
	{
		icon_theme = "BeautySolar";
		icon_theme_pkg = pkgs.beauty-solar;
		colorPalette =
		{
			ansiiPrimary = "136;0;0";
			ansiiSecondary = "255;0;135";
			ansiiTertiary = "255;215;0";
			ansiiText = "255;255;255";
		};
	};

	my.symlinks =
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

	my.vscodium.settings.workbench.colorTheme = "Sweet Dracula Monokai";

	my.unreal-engine =
	{
		enable = true;
		IDE.rider = true;
		enginePath = "/home/paczek/data/appdata/UnrealEngine/Linux_Unreal_Engine_5.7.4";
	};
}