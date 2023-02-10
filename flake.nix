{
  description = "A shared Standard data collection";
  inputs = {
    std.url = "github:divnix/blank";
    nixpkgs.url = "github:divnix/blank";
  };
  outputs = {std, ...} @ inputs: builtins.removeAttrs (
    std.grow {
      inherit inputs;
      cellsFrom = std.incl ./. [
        "data"
      ];
      cellBlocks = with std.blockTypes; [
        (nixago "configs")
      ];
    }
  ) ["__std"];
}
