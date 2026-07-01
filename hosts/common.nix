{ config, lib, ... }:
let
	colorPalette = config.my.platform-theme.colorPalette;
in
{
	system.stateVersion = "25.11";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

	boot =
	{
		loader =
		{
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
		initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" ];
	};

	fileSystems =
	{
		"/" =
		{
			device = "/dev/disk/by-label/root";
			fsType = "ext4";
		};

		"/boot" =
		{
			device = "/dev/disk/by-label/EFI";
			fsType = "vfat";
			options = [ "fmask=0077" "dmask=0077" ];
		};

		"/data" =
		{
			device = "/dev/disk/by-label/data";
			fsType = "btrfs";
		};
	};

	time.timeZone = "Europe/Warsaw";

	my.locale =
	{
		enable = true;
		defaultLocale = "en_US.UTF-8";
		dataLocale = "pl_PL.UTF-8";
		keymap = "pl";
		consoleKeymap = "pl2";
	};

	my.user =
	{
		enable = true;
		username = "paczek";
	};

	my.bash =
	{
		enable = true;
		prompt =
		{
			enable = true;
			plaques =
			[
				{
					command = "date +\"%H:%M\"";
					textColorCode = colorPalette.ansiiText;
					bgColorCode = colorPalette.ansiiPrimary;
				}
				{
					command = "whoami";
					textColorCode = colorPalette.ansiiText;
					bgColorCode = colorPalette.ansiiSecondary;
				}
				{
					command = "hostname";
					textColorCode = colorPalette.ansiiText;
					bgColorCode = colorPalette.ansiiPrimary;
				}
				{
					command = ''pwd | sed "s/^\/home\/$(whoami)/~/"'';
					textColorCode = "0";
					bgColorCode = "15";
				}
				{
					condition = "git status &> /dev/null";
					command = ''echo "$(git branch --show-current)$([ -n "$(git status -s)" ] && echo '*')"'';
					textColorCode = colorPalette.ansiiSecondary;
					bgColorCode = colorPalette.ansiiTertiary;
				}
			];
		};
		settings.shellAliases.pass = "/data/pass.sh";
	};

	my.waybar =
	{
		modules-left =
		[
			"custom/refresh"
			"hyprland/workspaces"
		];
		modules-center =
		[
			"hyprland/window"
		];
		modules-right =
		[
			"keyboard-state"
			"idle_inhibitor"
			"pulseaudio"
			"network"
			"power-profiles-daemon"
			"custom/brightness"
			"clock"
			"tray"
			"custom/poweroff"
			"custom/reboot"
			"custom/logout"
		];
	};

	my.git =
	{
		enable = true;
		settings =
		{
			core.editor = "nano";
			init.defaultbranch = "main";
			push.autoSetupRemote = "true";
			user =
			{
				name = "paczek654321";
				email = "paczek1024@proton.me";
			};
		};
	};
}