{ lib, config, ... }:
{
	options.my.ssh.enable = lib.mkEnableOption "Enable SSH";

	config = lib.mkIf config.my.ssh.enable
	{
		home-manager.users."${config.my.user.username}" = hm:
		let
			mkOutOfStoreSymlink = hm.config.lib.file.mkOutOfStoreSymlink;
		in
		{
			home.file =
			{
				".ssh".source = mkOutOfStoreSymlink "/data/.ssh";
			};
		};
	};
}