{config, lib, pkgs, inputs, ...}:
let
	username = config.my.user.username;
	cfg = config.my.platform-theme;
in
{

options.my.platform-theme =
{
	enable = lib.mkEnableOption "Enable system theming";
	colorPalette = lib.mkOption
	{
		type = lib.types.submodule
		{
			options =
			{
				ansiiPrimary = lib.mkOption
				{
					type = lib.types.str;
					description = "Primary color in the ANSII256 format";
				};
				ansiiSecondary = lib.mkOption
				{
					type = lib.types.str;
					description = "Secondary color in the ANSII256 format";
				};
				ansiiTertiary = lib.mkOption
				{
					type = lib.types.str;
					description = "Tertiary color in the ANSII256 format";
				};
				ansiiText = lib.mkOption
				{
					type = lib.types.str;
					description = "Text color in the ANSII256 format";
				};
				primaryAccent = lib.mkOption
				{
					type = lib.types.str;
					description = "Primary accent color in the HEX format";
				};
				secondaryAccent = lib.mkOption
				{
					type = lib.types.str;
					description = "Secondary accent color in the HEX format";
				};
				background = lib.mkOption
				{
					type = lib.types.str;
					description = "Background color in the HEX format";
				};
			};
		};
		description = "System color palette";
	};
	font_size = lib.mkOption
	{
		type = lib.types.int;
		default = 11;
		description = "Font size";
    };
	default_font = lib.mkOption
	{
		type = lib.types.str;
		description = "Normal (non-monospace) font";
    };
	monospace_font = lib.mkOption
	{
		type = lib.types.str;
		description = "Monospace font";
    };
	font_pkg = lib.mkOption
	{
		type = lib.types.package;
		description = "Font package";
    };
	icon_theme = lib.mkOption
	{
		type = lib.types.str;
		description = "Icon theme name";
    };
	icon_theme_pkg = lib.mkOption
	{
		type = lib.types.package;
		description = "Icon theme package";
    };
	qt_colorscheme_path = lib.mkOption
	{
		type = lib.types.path;
		description = "QT color scheme path";
    };
	cursor_name = lib.mkOption
	{
		type = lib.types.str;
		description = "Cursor name";
    };
	cursor_pkg = lib.mkOption
	{
		type = lib.types.package;
		description = "Cursor package";
    };
};

config = lib.mkIf config.my.platform-theme.enable
{
	home-manager.users."${username}" =
	{
		home.pointerCursor =
		{
			enable = true;

			package = cfg.cursor_pkg;
			name = cfg.cursor_name;

			size = 24;

			gtk.enable = true;
			x11.enable = true;
			hyprcursor.enable = true;
		};
		
		qt =
		{
			enable = true;
			
			platformTheme.name = "qtct";

			qt6ctSettings =
			{
				Appearance =
				{
					style = "Breeze";
					icon_theme = cfg.icon_theme;
					color_scheme_path=cfg.qt_colorscheme_path;
					custom_palette=true;
				};
				Fonts =
				{
					fixed = " \"${cfg.monospace_font}, ${toString cfg.font_size}\" ";
					general = " \"${cfg.default_font}, ${toString cfg.font_size}\" ";
				};
			};
			qt5ctSettings = config.home-manager.users."${username}".qt.qt6ctSettings;
		};

		gtk =
		{
			enable = true;
			
			theme =
			{
				name = "Breeze-Dark";
				package = pkgs.kdePackages.breeze-gtk;
			};
			
			iconTheme =
			{
				name = cfg.icon_theme;
				package = cfg.icon_theme_pkg;
			};

			font =
			{
				name = cfg.default_font;
				size = cfg.font_size;
				package = cfg.font_pkg;
			};

			gtk4.theme = config.home-manager.users."${username}".gtk.theme;
		};
	};
};

}