{lib, config, pkgs, ...}:
let
	username = config.my.user.username;
in
{
	options.my.ddcci =
	{
		enable = lib.mkEnableOption "Enable DDCCI";
		displayDev = lib.mkOption
		{
			type = lib.types.str;
			description = "Pattern used to find i2c backlight compatible displays";
		};
	};

	config = lib.mkIf config.my.ddcci.enable
	{
		hardware.i2c.enable = true;

		boot =
		{
			kernelModules =
			[
				"i2c-dev"
				"ddcci_backlight"
			];
			extraModulePackages =
			[
				config.boot.kernelPackages.ddcci-driver
			];
		};
		services.udev.extraRules =
		let
			bash = "${pkgs.bash}/bin/bash";
		in
		''
			SUBSYSTEM=="i2c", ACTION=="add", ATTR{name}=="${config.my.ddcci.displayDev}", \
				RUN+="${bash} -c 'sleep 30; printf ddcci\ 0x37 > /sys/bus/i2c/devices/%k/new_device'"
		'';

		users.users."${username}".extraGroups = [ "i2c" ];
		home-manager.users."${username}".home.packages = with pkgs; [ddcutil];
	};
}
