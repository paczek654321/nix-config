{ inputs, config, ... }:
let
	colorPalette = config.my.platform-theme.colorPalette;
in
{
	imports = [ inputs.umbriel.nixosModules.default ];

	programs.umbriel.enable = true;

	home-manager.users."${config.my.user.username}" =
	{
		imports = [ inputs.umbriel.homeModules.default ];

		programs.umbriel =
		{
			enable = true;
			settings =
			{
				include.files =
				[
					"/run/current-system/sw/share/umbriel/effects/animation/squash/effect.toml"
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
				input.focus.follows_mouse = true;
				appearance =
				{
					corner_radius = 10;
				};
				colors =
				{
					background = "#${colorPalette.background}";
					accent_primary = "#${colorPalette.primaryAccent}";
					accent_secondary = "#${colorPalette.secondaryAccent}";
					insert_hint = "#${colorPalette.primaryAccent}80";

					border =
					{
						focused = "#${colorPalette.primaryAccent}";
						unfocused = "#${colorPalette.background}";
					};
				};
				window_rule =
				[
					{
						blur = true;
					}
				];
			};
		};
	};

}