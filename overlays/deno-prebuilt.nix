final: prev: {
  deno = prev.stdenvNoCC.mkDerivation rec {
    pname = "deno";
    version = "2.7.13";
    src = prev.fetchurl {
      url = "https://github.com/denoland/deno/releases/download/v${version}/deno-x86_64-unknown-linux-gnu.zip";
      hash = "sha256-17RS3iV4dCiJtwp+PPkOsUuOaxvKR1g4DaNjDWlPBP8=";
    };
    nativeBuildInputs = [ prev.unzip ];
    dontBuild = true;
    dontStrip = true;
    unpackPhase = ''
      unzip $src
    '';
    installPhase = ''
      mkdir -p $out/bin
      install -Dm755 deno $out/bin/deno
    '';
    meta = {
      description = "A secure runtime for JavaScript and TypeScript";
      homepage = "https://deno.land/";
      license = prev.lib.licenses.mit;
      mainProgram = "deno";
    };
  };
}
