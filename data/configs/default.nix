{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  inherit (inputs.std.lib) cfg;

  inherit (nixpkgs.lib) recursiveUpdate stringsWithDeps;
in {
  adrgen = recursiveUpdate cfg.adrgen {
    data = import ./adrgen.nix;
  };
  editorconfig = recursiveUpdate cfg.editorconfig {
    data = import ./editorconfig.nix;
    hook.mode = "copy"; # already useful before entering the devshell
  };
  conform = recursiveUpdate cfg.conform {
    data = import ./conform.nix;
  };
  lefthook = recursiveUpdate cfg.lefthook {
    data = import ./lefthook.nix;
  };
  mdbook = recursiveUpdate cfg.mdbook {
    data = import ./mdbook.nix;
    hook.mode = "copy"; # let CI pick it up outside of devshell
    packages = [std.packages.mdbook-kroki-preprocessor];
  };
  treefmt = recursiveUpdate cfg.treefmt {
    data = import ./treefmt.nix;
    packages = [
      nixpkgs.alejandra
      nixpkgs.nodePackages.prettier
      nixpkgs.nodePackages.prettier-plugin-toml
      nixpkgs.shfmt
    ];
    devshell.startup.prettier-plugin-toml = stringsWithDeps.noDepEntry ''
      export NODE_PATH=${nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:''${NODE_PATH-}
    '';
  };
  githubsettings = recursiveUpdate cfg.githubsettings {
    data = import ./githubsettings.nix;
  };
}
