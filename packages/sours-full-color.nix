{pkgs}:
let
	path = "Sours-Full-Color";
in
pkgs.stdenv.mkDerivation
{
	name = "sours-full-color";

	src = pkgs.fetchgit
	{
		url = "https://github.com/tully-t/Sours.git";
		rev = "a7027ca599d1cba293d769fb23f3c225dd1edbc0";
		hash = "sha256-1egCvrzqZpR0X4RvkCc8OpnJWtMhwzJnbszCtvrR7/4=";
		sparseCheckout = [ path ];
	};
	installPhase =
	''
		mkdir -p $out/share/icons
		cp -r "$src/${path}" $out/share/icons
	'';

	preFixup =
	''
		find $out -xtype l -delete
	'';
}