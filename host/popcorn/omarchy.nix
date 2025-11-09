{
	inputs,
	pkgs,
	...
} : 
{
	imports = [ 
    		inputs.omarchy-nix.nixosModules.default
	];
	omarchy = {
		full_name = "Moritz Zimmerman";
		email_address = "dinhnhattai.nguyen@hotmail.com";
		theme = "everforest";
		exclude_packages = with pkgs; [
			vscode
			spotify
			typora
		        dropbox
		        spotify
    		];	
	};
}

