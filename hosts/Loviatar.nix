{ config, lib, pkgs, inputs, ... }:
let
	colorPalette = config.my.platform-theme.colorPalette;
in
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
			mode = "2560x1440@165.080";
			position = [0 0];
		};

		"HDMI-A-1" =
		{
			mode = "";
		};
	};

	my.platform-theme = lib.mkDefault
	{
		icon_theme = "Sours-Full-Color";
		icon_theme_pkg = pkgs.sours-full-color;
		colorPalette =
		{
			ansiiPrimary = "118";
			ansiiSecondary = "226";
			ansiiTertiary = "28";
			ansiiText = "18";
			primaryAccent = "5AD950";
			secondaryAccent = "f5f844";
			background = "242424";
		};
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
