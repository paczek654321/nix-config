{ config, ... }:
let
	username = config.my.user.username;
in
{

config =
{
	my.umbriel.settings =
	{
		general.autostart = [ "noctalia" ];

		keybinds =
		{
			"Mod+1" = "spawn noctalia msg panel-toggle launcher";

			"Mod+S" = "spawn noctalia msg screenshot-region";

			"Mod+Escape" = "spawn noctalia msg session lock";

			"XF86AudioRaiseVolume" = "spawn noctalia msg volume-up";
			"XF86AudioLowerVolume" = "spawn noctalia msg volume-down";
			"XF86AudioMute" = "spawn noctalia msg volume-mute";
			
			"XF86MonBrightnessUp" = "spawn noctalia msg brightness-up";
			"XF86MonBrightnessDown" = "spawn noctalia msg brightness-down";
			
			"XF86AudioNext" = "spawn noctalia msg media next";
			"XF86AudioPrev" = "spawn noctalia msg media previous";
			"XF86AudioPause" = "spawn noctalia msg media pause";
			"XF86AudioPlay" = "spawn noctalia msg media toggle";
		};

		layer_rule =
		[
			{
				match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
				blur = true;
				blur_ignore_alpha = 0.6;
				blur_optimized = false;
			}
		];

		include.optional.files = [ "/home/${username}/.config/umbriel/noctalia.toml" ];
	};
};

}
