#!/bin/bash

# Script: ganti-warna.sh
# Deskripsi: Mengganti preset warna di niri/config.kdl dan niri/warnaumum.css
# Penggunaan: ./ganti-warna.sh -w <nama_warna>

# Inisialisasi variabel
COLOR=""

# Parsing argumen
while getopts "w:" opt; do
  case $opt in
    w) COLOR="$OPTARG" ;;
    *) echo "Usage: $0 -w <warna>"; exit 1 ;;
  esac
done

# Validasi argumen
if [ -z "$COLOR" ]; then
    echo "Error: Argumen -w diperlukan."
    echo "Usage: $0 -w <warna>"
    exit 1
fi

# Setup direktori (relatif terhadap lokasi script ini)
# diasumsikan script berada di niri/scripts/
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NIRI_DIR="$(dirname "$SCRIPT_DIR")"
PRESET_DIR="$NIRI_DIR/preset-warna"

# Path ke file konfigurasi yang akan diubah
CONFIG_KDL="$NIRI_DIR/config.kdl"
WARNA_CSS="$NIRI_DIR/warnaumum.css"
CONFIG_MAKO="$NIRI_DIR/mako/config"

# Validasi keberadaan file preset
if [ ! -f "$PRESET_DIR/$COLOR.kdl" ]; then
    echo "Error: File preset KDL tidak ditemukan: $PRESET_DIR/$COLOR.kdl"
    exit 1
fi

if [ ! -f "$PRESET_DIR/$COLOR.css" ]; then
    echo "Error: File preset CSS tidak ditemukan: $PRESET_DIR/$COLOR.css"
    exit 1
fi

if [ ! -f "$PRESET_DIR/$COLOR" ]; then
    echo "Error: File preset mako tidak ditemukan: $PRESET_DIR/$COLOR.kdl"
    exit 1
fi

# Update config.kdl
# Mencari baris 'include "preset-warna/..."' dan menggantinya
if [ -f "$CONFIG_KDL" ]; then
    sed -i "s|include \"preset-warna/.*\.kdl\"|include \"preset-warna/$COLOR.kdl\"|" "$CONFIG_KDL"
    echo "Updated $CONFIG_KDL -> preset-warna/$COLOR.kdl"
else
    echo "Warning: $CONFIG_KDL tidak ditemukan."
fi

# Update warnaumum.css
# Mencari baris '@import "preset-warna/..."' dan menggantinya
if [ -f "$WARNA_CSS" ]; then
    sed -i "s|@import \"preset-warna/.*\.css\";|@import \"preset-warna/$COLOR.css\";|" "$WARNA_CSS"
    echo "Updated $WARNA_CSS -> preset-warna/$COLOR.css"
else
    echo "Warning: $WARNA_CSS tidak ditemukan."
fi

# Update mako
if [ -f "$CONFIG_MAKO" ]; then
    sed -i "s|include=.*|include=~/.config/niri/preset-warna/$COLOR|" "$CONFIG_MAKO"
    echo "Updated $CONFIG_MAKO -> preset-warna/$COLOR"
else
    echo "Warning: $CONFIG_MAKO tidak ditemukan."
fi

echo "Warna berhasil diganti ke: $COLOR"
