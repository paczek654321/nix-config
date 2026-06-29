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

	fileSystems =
	{
		"/" =
		{
			device = "/dev/disk/by-id/nvme-Lexar_SSD_NM790_2TB_PDV7634101639P220J_1-part2";
			fsType = "ext4";
		};

		"/boot" =
		{
			device = "/dev/disk/by-id/nvme-Lexar_SSD_NM790_2TB_PDV7634101639P220J_1-part1";
			fsType = "vfat";
			options = [ "fmask=0077" "dmask=0077" ];
		};

		"/data" =
		{
			device = "/dev/disk/by-id/nvme-Lexar_SSD_NM790_2TB_PDV7634101639P220J_1-part3";
			fsType = "btrfs";
		};
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
	
	my.brave.enable = true;
	my.vesktop.enable = true;
	my.godot.enable = true;
	my.r2modman.enable = true;
	my.ssh.enable = true;
	my.fastfetch.enable = true;
	my.kde-partition-manager.enable = true;
	my.kitty.enable = true;
	my.easyeffects.enable = true;
	my.dolphin.enable = true;

	my.user.packages = with pkgs;
	[
		kdePackages.ark
		kdePackages.gwenview
		kdePackages.kate
		kdePackages.okular
		kdePackages.isoimagewriter
		kdePackages.filelight
		
		vlc
		xfburn
		libreoffice-fresh

		krita
		blender
		audacity
		lmms

		obs-studio
		obsidian
		spotify
		soundux

		gamemode
		heroic
		steam

		unityhub
		dotnet-sdk
		python3

		cryptsetup
		steam-run
		openssl

		nerd-fonts.symbols-only
	];

	my.hyprland-de =
	{
		enable = true;
		workspaces.monitors =
		[
			"DP-1"
			"DP-2"
		];
		settings =
		{
			monitor =
			[
				"DP-1, highrr, auto-right, 1"
				"DP-2, highrr, auto-left, 1"
				"HDMI-A-1, disable"
			];
		};
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

	my.platform-theme =
	{
		font_size = 11;
		default_font = "Adwaita Sans";
		monospace_font = "Adwaita Mono";
		font_pkg = pkgs.adwaita-fonts;
		icon_theme = "Cool-Dark-Icons";
		icon_theme_pkg = pkgs.cool-dark-icons;
		qt_colorscheme_path = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
		cursor_name = "breeze_cursors";
		cursor_pkg = pkgs.kdePackages.breeze;

		colorPalette =
		{
			ansiiPrimary = "165";
			ansiiSecondary = "57";
			ansiiTertiary = "111";
			ansiiText = "15";
			primaryAccent = "aa33ff";
			secondaryAccent = "ff33aa";
			background = "242424";
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

	my.vscodium =
	{
		enable = true;
		settings =
		{
			editor =
			{
				tabSize = 4;
				insertSpaces = false;
				detectIndentation = false;
			};
			"[nix]".editor = config.my.vscodium.settings.editor;
			workbench.colorTheme = "Sweet Dracula Monokai";
		};
	};
}