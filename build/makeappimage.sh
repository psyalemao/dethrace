 #!/usr/bin/env bash

if [ ! -f appimagetool-x86_64.AppImage ]; then
    wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
    chmod +x appimagetool-x86_64.AppImage
fi

if [ ! -f linuxdeploy-x86_64.AppImage ]; then
    wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
    chmod +x linuxdeploy-x86_64.AppImage
fi

cat > "/usr/share/applications/dethrace.desktop" << EOF
[Desktop Entry]
Name=dethrace
Comment=Carmageddon Decompilation
Type=Application
Categories=Game;
MimeType=application/dethrace-labs.dethrace
Exec=dethrace %F
Icon=icon
EOF

DESTDIR=AppDir
./linuxdeploy-x86_64.AppImage --appimage-extract-and-run --appdir=AppDir -e ./dethrace \

rm AppDir/icon.png
pushd AppDir
ln -s usr/share/icons/hicolor/256x256/icon.png
chmod +x AppRun
popd
./appimagetool-x86_64.AppImage --appimage-extract-and-run AppDir
