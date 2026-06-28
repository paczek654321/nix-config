{ config, lib, pkgs, ...}:
{

options.my.kde-partition-manager.enable = lib.mkEnableOption "Enable KDE partition manager";

config = lib.mkIf config.my.kde-partition-manager.enable
{
	environment.systemPackages = with pkgs; [kdePackages.partitionmanager pulseaudio];
};

}