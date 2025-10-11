final: prev: {
  material-symbols = prev.material-symbols.overrideAttrs (oldAttrs: {
    version = "4.0.0-unstable-2025-04-11";
    src = final.fetchFromGitHub {
      owner = "google";
      repo = "material-design-icons";
      rev = "941fa95d7f6084a599a54ca71bc565f48e7c6d9e";
      hash = "sha256-5bcEh7Oetd2JmFEPCcoweDrLGQTpcuaCU8hCjz8ls3M=";
      sparseCheckout = [ "variablefont" ];
    };
  });
}