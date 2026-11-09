{ lib, config, ... }:
{
	options.my.ssh.enable = lib.mkEnableOption "Enable SSH";

	config = lib.mkIf config.my.ssh.enable
	{
		my.symlinks =
		[
			{
				source = "/data/.ssh";
				destination = ".ssh";
			}
		];
	};
}