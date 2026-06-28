{ config, lib, ... }:
{

options.my.backups =
{
	enable = lib.mkEnableOption "Enable backups";
	files = lib.mkOption
	{
		type = lib.types.listOf (lib.types.submodule
		{
			options =
			{
				source = lib.mkOption
				{
					type = lib.types.str;
					description = "Source path";
				};
				destination = lib.mkOption
				{
					type = lib.types.str;
					description = "Destination path";
				};
			};
		});
		description = "Files to back up";
	};
};

config = lib.mkIf config.my.backups.enable
{
	home-manager.users."${config.my.user.username}" = hm:
	let
		mkOutOfStoreSymlink = hm.config.lib.file.mkOutOfStoreSymlink;
	in
	{
		home.file = builtins.listToAttrs (map (file:
		{
			name = file.destination;
			value = { source = mkOutOfStoreSymlink file.source; };
		}) config.my.backups.files);
	};
};

}