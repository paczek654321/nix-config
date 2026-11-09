{ self, lib, ... }:
{

options.my.util =
{
	relPath = lib.mkOption
	{
		type = lib.types.functionTo lib.types.str;
		description = "Takes a global path and returns a string representing the same path relative to the flake root";
		default = path: lib.strings.removePrefix "${self}/" (toString path);
	};
};

}