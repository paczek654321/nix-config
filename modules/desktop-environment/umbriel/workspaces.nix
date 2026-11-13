{ config, ... }:
let
	username = config.my.user.username;
	monitors = builtins.attrNames config.my.umbriel.output;
	combine = actions: "spawn umbriel msg ${builtins.concatStringsSep "; umbriel msg " actions}";
	mkSwitchCommands = workspace: map (m: "workspace-switch ${workspace} --output ${m}") monitors;
in
{

config =
{
	my.umbriel.settings.keybinds =
	{
		"Alt+Tab" = "submap workspaces";
	}
	//
	builtins.listToAttrs
	(
		map (workspace:
		let
			key = if workspace == "10" then "0" else  workspace;
		in
		{
			name = "submap[workspaces],${key}";
			value =
			{
				action = combine (mkSwitchCommands workspace);
				submap = "reset";
			};
		}) (builtins.genList (i: toString (i + 1)) 10)
	)
	//
	builtins.listToAttrs
	(
		map (workspace:
		let
			key = if workspace == "10" then "0" else  workspace;
		in
		{
			name = "Alt+Shift+${key}";
			value =
			{
				action = combine ([ "window-move-to-workspace ${workspace}" ] ++ mkSwitchCommands workspace);
				submap = "reset";
			};
		}) (builtins.genList (i: toString (i + 1)) 10)
	)
	//
	builtins.listToAttrs
	(
		builtins.genList (i:
		{
			name = "submap[workspaces],F${toString (i + 1)}";
			value = combine [ "submap reset" "submap workspaces_${builtins.elemAt monitors i}" ];
		}) (builtins.length monitors)
	)
	//
	builtins.listToAttrs (builtins.concatLists (
		map (monitor:
			builtins.genList (i:
				let
					workspace = toString (i + 1);
					key = if workspace == "10" then "0" else workspace;
				in
				{
					name = "submap[workspaces_${monitor}],${key}";
					value =
					{
						action = "workspace-switch ${workspace} --output ${monitor}";
						submap = "reset";
					};
				}
			) 10
		) monitors
		));
};

}
