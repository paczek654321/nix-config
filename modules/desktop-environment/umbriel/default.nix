{ inputs, pkgs, config, lib, ... }:
let
	colorPalette = config.my.platform-theme.colorPalette;
	username = config.my.user.username;
in
{

imports =
[
	inputs.umbriel.nixosModules.default

	(lib.mkAliasOptionModule [ "my" "umbriel" "settings" ] [ "home-manager" "users" username "programs" "umbriel" "settings" ] )
];

# Lift output out of the shared config object to avoid resursion issues
options.my.umbriel.output = lib.mkOption
{
	type = lib.types.attrsOf lib.types.anything;
	default = {};
	description = "Monitor configurations.";
};

config =
{
	programs.umbriel.enable = true;

	home-manager.users."${username}" =
	{
		imports = [ inputs.umbriel.homeModules.default ];

		programs.umbriel =
		{
			enable = true;
			settings =
			{
				include.files =
				[
					"/run/current-system/sw/share/umbriel/effects/border/accent-gradient/effect.toml"
				];

				layout =
				{
					mode = "dwindle";
					gap = 10;
					extent_presets = [ 0.5 0.25 ];
					dwindle =
					{
						preserve_split = true;
						new_toward_cursor = true;
					};
					struts =
					{
						left = 15;
						right = 15;
						top = 15;
						bottom = 15;
					};
				};

				input =
				{
					focus.follows_mouse = true;
					keyboard.layout = config.my.locale.keymap;
				};

				appearance =
				{
					prefer_no_csd = true;
					corner_radius = 10;
				};

				window_rule =
				[
					{
						blur = true;
						blur_optimized = true;
					}
				];

				keybinds =
				{
					"Mod" = "submap reset";
					"Mod+Grave" = "submap ignore";

					"Mod+Q" = "window-close";
					"Mod+V" = "window-toggle-floating";
					"Mod+MouseMiddle" = "layout-toggle-split";
					"Mod+Left" = "window-focus-or-output-left";
					"Mod+Right" = "window-focus-or-output-right";
					"Mod+Up" = "window-focus-or-output-up";
					"Mod+Down" = "window-focus-or-output-down";
				};

				effects =
				{
					border = "accent-gradient";
				};

				output = config.my.umbriel.output;
			};
		};
	};

	environment.systemPackages =
	[
		inputs.umbriel-accent-gradient.packages.${pkgs.stdenv.hostPlatform.system}.default
	];

};

}
