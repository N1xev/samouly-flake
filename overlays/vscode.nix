final: prev: {
  vscode = prev.vscode.overrideAttrs (oldAttrs: rec {
    version = "1.105.0";
    
    src = prev.fetchurl {
      name = "VSCode_${version}_linux-x64.tar.gz";
      url = "https://update.code.visualstudio.com/${version}/linux-x64/stable";
      sha256 = "1jl2f9w657kiiik54hlg5qzkznircp3gr70cqqphp26nlyv0alwb";
    };
  });
}