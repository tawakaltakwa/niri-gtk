#!/bin/bash

# Tentukan folder tempat menyimpan koleksi gambar
FOLDER_GAMBAR="$HOME/.config/fastfetch/koleksi"

# Ambil satu gambar secara acak dari folder tersebut
# Mendukung format png, jpg, jpeg, dan webp
GAMBAR_ACAK=$(find "$FOLDER_GAMBAR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) | shuf -n 1)

# Jalankan konsole dengan gambar acak yang terpilih
if [ -n "$GAMBAR_ACAK" ]; then
    kitty -- bash -c "fastfetch --logo '$GAMBAR_ACAK'; exec bash"
else
    # Jika folder kosong atau tidak ditemukan, jalankan fastfetch biasa
    kitty -- bash -c "fastfetch; exec bash"
fi
