{ pkgs, lib }:
pkgs.stdenv.mkDerivation
{
	name = "soundux";

	src = pkgs.fetchgit
	{
		url = "https://github.com/Soundux/Soundux.git";
		rev = "refs/pull/747/head";
		hash = "sha256-MdTIENw0gs7A5LlDIYgogyfb11Ppyoim7bkI9Q2tqiY=";
	};

	nativeBuildInputs = with pkgs;
	[
		cmake
		pkg-config
	];

	buildInputs = with pkgs;
	[
		pipewire
		libpulseaudio
		libx11
		libXtst
		gtk3
		webkitgtk_4_1
		libayatana-appindicator
		tl-expected
		openssl
	];

	cmakeFlags =
	[
		"-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
		"-DFETCHCONTENT_SOURCE_DIR_EXPECTED=${pkgs.tl-expected.src}"
	];

	installPhase =
	''
		opt="$out/opt/soundux"
		mkdir -p $opt
		cp -r dist $opt/
		cp $(readlink soundux) $opt/soundux

		mkdir -p $out/bin
		ln -s $opt/soundux $out/bin/

		icons="$out/share/pixmaps"
		mkdir -p $icons
		cp $src/assets/soundux.png $icons/

		apps="$out/share/applications"
		mkdir -p $apps
		cp $src/deployment/soundux.desktop $apps/

		substituteInPlace $apps/soundux.desktop \
			--replace-fail "/opt/soundux/soundux" "soundux"
	'';

	postFixup =
	let
		rpaths = lib.makeLibraryPath (with pkgs; [ pipewire libpulseaudio ]);
	in
	''
		# PipeWire and PulseAudio are dlopen-ed by Soundux, so they do
		# not end up on the RPATH during the build process.
		patchelf --add-rpath "${rpaths}" "$out/opt/soundux/soundux"
	'';
}