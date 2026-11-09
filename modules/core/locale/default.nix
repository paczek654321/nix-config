{ config, lib, pkgs, ...}:
{

options.my.locale =
{
	enable = lib.mkEnableOption "Enable locale";
	defaultLocale = lib.mkOption
	{
		type = lib.types.str;
		description = "";
	};
	dataLocale = lib.mkOption
	{
		type = lib.types.str;
		description = "Locale used for data such as dates, phone numbers, etc.";
	};
	keymap = lib.mkOption
	{
		type = lib.types.str;
		description = "Default keymap";
	};
	keymapVariant = lib.mkOption
	{
		type = lib.types.str;
		default = "";
		description = "Default keymap variant";
	};
	consoleKeymap = lib.mkOption
	{
		type = lib.types.str;
		description = "Console keymap";
	};
};

config = lib.mkIf config.my.locale.enable
{
	i18n =
	{
		defaultLocale = config.my.locale.defaultLocale;
		extraLocaleSettings =
		{
			LC_ADDRESS = config.my.locale.dataLocale;
			LC_IDENTIFICATION =  config.my.locale.dataLocale;
			LC_MEASUREMENT = config.my.locale.dataLocale;
			LC_MONETARY = config.my.locale.dataLocale;
			LC_NAME = config.my.locale.dataLocale;
			LC_NUMERIC = config.my.locale.dataLocale;
			LC_PAPER = config.my.locale.dataLocale;
			LC_TELEPHONE = config.my.locale.dataLocale;
			LC_TIME = config.my.locale.dataLocale;
		};
	};
	# Configure keymap in X11
	services.xserver.xkb =
	{
		layout = config.my.locale.keymap;
		variant = config.my.locale.keymapVariant;
	};
	# Configure console keymap
	console.keyMap = config.my.locale.consoleKeymap;
};

}