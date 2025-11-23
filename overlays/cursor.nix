final: prev: {
  cursor = prev.appimageTools.wrapType2 {
    pname = "cursor";
    name = "cursor";
    version = "1.7";
    
    src = prev.fetchurl {
      url = "https://api2.cursor.sh/updates/download/golden/linux-x64/cursor/1.7";
      hash = "sha256-/eLb6+ECxFmpzgtRIgfO2PPn28kFbA3Xmq8ZjPrDQ5g=";
    };

    extraPkgs = pkgs: with pkgs; [
      libgcc
      zlib
      glib
      gtk3
      at-spi2-atk
      cairo
      pango
      gdk-pixbuf
      mesa
      libdrm
      expat
      libxkbcommon
      xorg.libX11
      xorg.libxcb
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXrandr
      cups
      dbus
      nss
      nspr
      alsa-lib
    ];

    meta = with prev.lib; {
      description = "Cursor - The AI-first Code Editor";
      homepage = "https://cursor.com";
      license = licenses.unfree;
      platforms = [ "x86_64-linux" ];
    };
  };
}