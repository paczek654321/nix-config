{ lib, config, ... }:
{
	options.my.gpg.enable = lib.mkEnableOption "Enable GNUPG";

	config = lib.mkIf config.my.gpg.enable
	{
		my.symlinks =
		[
			{
				source = "/data/.gnupg";
				destination = ".gnupg";
			}
		];

		programs.gnupg.agent.enable = true;
	};
}