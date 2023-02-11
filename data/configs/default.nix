{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  inherit (inputs.std.lib) cfg;
  l = nixpkgs.lib // builtins;
in {
  adrgen = cfg.adrgen {
    data = import ./adrgen.nix;
  };
  editorconfig = cfg.editorconfig {
    data = import ./editorconfig.nix;
    hook.mode = "copy"; # already useful before entering the devshell
  };
  conform = cfg.conform {
    data = import ./conform.nix;
  };
  lefthook = cfg.lefthook {
    data = import ./lefthook.nix;
  };
  mdbook = cfg.mdbook {
    data = import ./mdbook.nix;
    hook.mode = "copy"; # let CI pick it up outside of devshell
    packages = [std.packages.mdbook-kroki-preprocessor];
  };
  treefmt = cfg.treefmt {
    data = import ./treefmt.nix;
    packages = [
      nixpkgs.alejandra
      nixpkgs.nodePackages.prettier
      nixpkgs.nodePackages.prettier-plugin-toml
      nixpkgs.shfmt
    ];
    devshell.startup.prettier-plugin-toml = l.stringsWithDeps.noDepEntry ''
      export NODE_PATH=${nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:$NODE_PATH
    '';
  };
  githubsettings = cfg.githubsettings {
    data = import ./githubsettings.nix;
  };
}
