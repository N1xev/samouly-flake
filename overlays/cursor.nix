# overlays/cursor.nix
final: prev: {
  code-cursor = prev.code-cursor.overrideAttrs (oldAttrs: rec {
    version = "1.7";
    
    src = prev.fetchurl {
      url = "https://api2.cursor.sh/updates/download/golden/linux-x64/cursor/${version}";
      hash = "sha256-/eLb6+ECxFmpzgtRIgfO2PPn28kFbA3Xmq8ZjPrDQ5g=";
    };
  });
}