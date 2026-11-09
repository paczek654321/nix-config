{ config, lib, ... }:
{

options.my.vsftpd.enable = lib.mkEnableOption "Enable vsftpd";

config = lib.mkIf config.my.vsftpd.enable
{
	networking.firewall.extraCommands = ''iptables -A nixos-fw -s 192.168.0.0/24 -j ACCEPT'';
	security.pam.services.vsftpd.enable = true;
	services.vsftpd =
	{
		enable = true;
		localUsers = true;
		writeEnable = true;
	};
};

}