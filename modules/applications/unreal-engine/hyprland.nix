{lib, config, ...}:
{

config = lib.mkIf (config.my.unreal-engine.enable && config.my.hyprland.enable)
{
	my.hyprland.settings.windowrule =
	[
		{
			name = "fix-unreal-tooltips";
			"match:class" = "UnrealEditor";
			"match:initial_title" = "^$";
			no_focus = true;
		}
	];
};

}
