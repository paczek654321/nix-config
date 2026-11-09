{ config, lib, ... }:
{

options.my.symlinks = lib.mkOption
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
	description = "Files to symlink";
};

config =
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
		}) config.my.symlinks);
	};
};

}