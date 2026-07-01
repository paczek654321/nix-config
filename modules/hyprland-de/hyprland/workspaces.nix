{ config, lib, pkgs,  ... }:
let
	concatMonitorsMap = f: builtins.concatMap (i: builtins.genList (f i) monitorCount) (builtins.genList(i: i) workspaceCount);
	workspaceIdx = w: m: toString (monitorCount*w + m + 1);
	idx2key = i: toString (pkgs.lib.trivial.mod (i + 1) 10);
	
	workspaceCount = 10;
	monitorCount = builtins.length monitors;

	monitors = config.my.hyprland-de.workspaces.monitors;
in
{

options.my.hyprland-de.workspaces.monitors = lib.mkOption
{
	type = lib.types.listOf lib.types.str;
	default = [ ];
	description = "Monitor names that workspaces should be created for";
};

config = lib.mkIf config.my.hyprland-de.enable
{
	home-manager.users."${config.my.user.username}".wayland.windowManager.hyprland =
	{
		settings =
		{
			"$workspaceMod" = "ALT_L";
			"$workspaceMoveMod" = "$workspaceMod SHIFT";
		
			workspace = concatMonitorsMap (w: m: "${workspaceIdx w m}, monitor:${builtins.elemAt monitors m}");
		
			bindns = concatMonitorsMap (w: m: "$workspaceMod, Tab&${idx2key w}, workspace, ${workspaceIdx w m}");

			bindn = concatMonitorsMap (w: m:
				if m == 0 then
					"$workspaceMoveMod, ${idx2key w}, movetoworkspace, ${workspaceIdx w m}"
				else
					"$workspaceMoveMod, ${idx2key w}, workspace, ${workspaceIdx w m}"
			);

			bind = builtins.genList (m:
				"$mainMod, F${toString (m + 1)}, submap, monitor_${toString (m + 1)}"
			) monitorCount;
		};
		submaps = builtins.foldl' (acc: m:
			acc //
			{
				"monitor_${toString (m + 1)}".settings.bindns = builtins.genList (w:
					"$workspaceMod, Tab&${idx2key w}, workspace, ${workspaceIdx w m}"
				) workspaceCount;
			}
		) {} (builtins.genList (i: i) monitorCount);
	};
};

}
