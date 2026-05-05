final: prev: {
  pixel-sddm-theme = prev.stdenv.mkDerivation {
    pname = "pixel-sddm-theme";
    version = "1.0";
    src = prev.fetchFromGitHub {
      owner = "mahaveergurjar";
      repo = "sddm";
      rev = "pixel";
      # Use this hash for the 'pixel' branch as of late 2024
      sha256 = "sha256-bzA6WUZrXgQDJvOuK5JIcnPJNRhU/8AiKg3jgAeeoBM=";
    };
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR . $out/share/sddm/themes/pixel
    '';
  };
}
