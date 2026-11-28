{ lib, pkgs, ... }:
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

	my.umbriel.output =
	{
		"DP-1" =
		{
			mode = "highest_refresh";
		};

		"DP-2" =
		{
			mode = "highest_refresh";
			position = [0 0];
		};
	};

	my.platform-theme = lib.mkDefault
	{
		icon_theme = "BeautySolar";
		icon_theme_pkg = pkgs.beauty-solar;
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