final: prev: {
  zed-editor = prev.stdenvNoCC.mkDerivation rec {
    pname = "zed";
    version = "1.1.2-pre";
    src = prev.fetchzip {
      url = "https://github.com/zed-industries/zed/releases/download/v${version}/zed-linux-x86_64.tar.gz";
      hash = "sha256-N68PzLCJefr402XNAOfN1hd5taesEmUyFcSMYIyeZS8=";
      stripRoot = true;
    };
    libPath = prev.lib.makeLibraryPath [ prev.wayland ];

    installPhase = ''
      mkdir -p $out/bin $out/zed-lib $out/libexec $out/share
      appdir=$(echo *.app)
      cp $appdir/bin/zed $out/bin/
      cp $appdir/libexec/zed-editor $out/libexec/zed-editor
      cp -r $appdir/lib/* $out/zed-lib/
      cp -r $appdir/share/* $out/share/ 2>/dev/null || true

      # Patch main zed binary
      patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 $out/bin/zed
      patchelf --set-rpath $out/zed-lib:${libPath} $out/bin/zed

      # Patch remote server binary
      patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 $out/libexec/zed-editor
      patchelf --set-rpath $out/zed-lib:${libPath} $out/libexec/zed-editor
    '';

    # Prevent fixupPhase from shrinking our RPATHs
    dontFixup = true;

    nativeBuildInputs = [ prev.patchelf ];

    meta = {
      description = "High-performance, multiplayer code editor";
      homepage = "https://zed.dev/";
      license = prev.lib.licenses.gpl3Only;
      mainProgram = "zed";
    };
  };
}
