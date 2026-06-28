{ pkgs, lib }:
let
	arch = builtins.replaceStrings [ "-" ] [ "_" ] pkgs.stdenv.hostPlatform.parsed.cpu.arch;
	libs = with pkgs;
	[
		libXrandr
		libx11
		libXcursor
		libXinerama
		libXi
		libxrender
		libXext
		
		wayland
		wayland-scanner
		
		libglvnd
		mesa
		vulkan-loader

		alsa-lib
		pulseaudio
		dbus

		fontconfig
		libxkbcommon
	];
in
pkgs.stdenv.mkDerivation
{
	name = "godot-custom";

	src = pkgs.fetchgit
	{
		url = "https://github.com/paczek654321/godot";
		rev = "6d25d159d391c6735d031ce5cc2f29e708173001";
		hash = "sha256-gpwAGmOAKSMNAj8Fdn7OFyGfrqMagWNMwNX3O6carMs=";
	};

	nativeBuildInputs = with pkgs;
	[
		pkg-config
		scons
		gcc
		python3
	];

	runtimeDependencies = libs;

	postPatch =
	''
    	substituteInPlace version.py \
    		--replace "stable" "custom"
  	'';

	buildPhase =
	''
		scons -j$(nproc) platform=linuxbsd target=editor arch=${arch}
		scons -j$(nproc) platform=linuxbsd target=template_release arch=${arch}
	'';

	installPhase =
	''
		mkdir -p "$out/bin"
		cp "bin/godot.linuxbsd.editor.${arch}" "$out/bin/godot"

		version=$(python -c 'from version import *; print(f"{major}.{minor}.{patch}.{status}")')

		icons="$out/share/icons"
		mkdir -p "$icons"
		cp "icon.svg" "$icons/godot.svg"

		apps="$out/share/applications"
		mkdir -p "$apps"
		cp "misc/dist/linux/org.godotengine.Godot.desktop" "$apps/"

		templates="$out/share/godot/export_templates/$version"
		mkdir -p "$templates"
		cp "bin/godot.linuxbsd.template_release.${arch}" "$templates/"
	'';

	postFixup =
	''
		patchelf --add-rpath "${lib.makeLibraryPath libs}" "$out/bin/godot"
	'';
}