{pkgs}:
let
	path = "Cool Icons Themes/Cool-Dark-Icons";
in
pkgs.stdenv.mkDerivation
{
	name = "cool-dark-icons";

	src = pkgs.fetchgit
	{
		url = "https://github.com/L4ki/Cool-Plasma-Themes.git";
		rev = "45862e545784805aed1f8cd1d9a3c88231c8ec32";
		hash = "sha256-i2xclp5NBEBHyfCI5wTsPuA7o7W1+Jf2HHH0m5d9Zws=";
		sparseCheckout = [ path ];
	};
	installPhase =
	''
		mkdir -p $out/share/icons
		cp -r "$src/${path}" $out/share/icons
		rm -f $out/share/icons/16/inode-directory.svg
	'';
}