
Install
https://nixos.org/manual/nix/stable/#chap-quick-start
bash <(curl -L https://nixos.org/nix/install)

Search
    all available packages
        nix-env -qa 

Install/uninstall/rollback

    install pre-built pkg
        nix-env -i hello

    uninstall -e

    undo an nix-env action
        nix-env --rollback

    remove ophaned pkgs
        nix-collect-garbage -d

nix-shell - ad-hoc dev env
	Test pkg without installing
    nix-shell -p hello

Update installed
    nix-channel --update nixpkgs
    nix-env -u '*'


Fish nix-end plugin - added nix apps to path
https://github.com/lilyball/nix-env.fish


    
