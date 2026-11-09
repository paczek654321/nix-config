{pkgs}:
let
	path = "BeautySolar";
in
pkgs.stdenv.mkDerivation
{
	name = "beauty-solar";

	src = pkgs.fetchgit
	{
		url = "https://github.com/musqz/beautysolar-icon-theme.git";
		rev = "f8a5d1c5093d965bccd59174519d01dbf7c3ca4b";
		hash = "sha256-5ctph5RF23LAoxpd+M1FjQ89gU/+zo2eWFxNYMcCevw=";
		sparseCheckout = [ path ];
	};

	patchPhase =
	''
		for dir in "${path}"/places/*/; do
			[ -d "$dir" ] || continue
			[ -f "$dir/folder.svg" ] || continue
			ln -sfn ./folder.svg "$dir/inode-directory.svg"
		done
	'';

	installPhase =
	''
		mkdir -p $out/share/icons
		cp -r "${path}" $out/share/icons
	'';
}