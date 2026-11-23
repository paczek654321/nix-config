{ lib, pkgs, ... }:
{
	imports = [ ./common.nix ];

	networking.hostName = "Loviatar";

	hardware =
	{
		graphics =
		{
			enable = true;
			enable32Bit = true;
		};
		nvidia =
		{
			modesetting.enable = true;
			powerManagement.enable = false;
			powerManagement.finegrained = false;
			open = false;
			nvidiaSettings = true;

			prime =
			{
				offload =
				{
					enable = true;
					enableOffloadCmd = true;
				};
				intelBusId = "PCI:0:2:0";
				nvidiaBusId = "PCI:1:0:0";
			};
		};
		enableRedistributableFirmware = true;
		cpu.intel.updateMicrocode = true;
	};

	services.xserver.videoDrivers = [ "modesetting" "nvidia"];

	boot.kernelPackages = pkgs.linuxPackages_latest;

	my.umbriel.output =
	{
		"eDP-1" =
		{
			mode = "1920x1080@60";
			position = [0 0];
		};

		"HDMI-A-1" =
		{
			mode = "1920x1080@60";
			position = [0 0];
		};
	};

	my.platform-theme = lib.mkDefault
	{
		icon_theme = "Sours-Full-Color";
		icon_theme_pkg = pkgs.sours-full-color;
	};
	
	my.symlinks =
	[
		{
			source = "/data/appdata/UnityEditor";
			destination = "/home/paczek/Unity/Hub/Editor";
		}
	];

	my.vscodium.settings.workbench.colorTheme = "Sweet Dracula Monokai";
}
