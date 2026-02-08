#!/system/bin/sh

# Dosya Yolları
VOLD_FSTAB="/system/etc/recovery-no-wrappedkey.fstab"
WRAPPED_FSTAB="/system/etc/recovery-wrappedkey.fstab"
TARGET_FSTAB="/system/etc/recovery.fstab"

echo "OrangeFox Encryption Switcher"
echo "------------------------------"

# 1. Kök dizini (rootfs) yazılabilir olarak yeniden bağla
# Bu adım olmadan kopyalama işlemi sessizce başarısız olur.
mount -o remount,rw / 2>/dev/null

# 2. Mevcut modu kontrol et ve değiştir
if grep -qiE "wrappedkey|wrapped-key" "$TARGET_FSTAB"; then
    echo "Current Mode : WRAPPEDKEY (Wrappedkey Fstab)"
    echo "Switching to : VOLD (Vold Fstab)"
    cp -f "$VOLD_FSTAB" "$TARGET_FSTAB"
else
    echo "Current Mode : VOLD (Vold Fstab)"
    echo "Switching to : WRAPPEDKEY (Wrappedkey Fstab)"
    cp -f "$WRAPPED_FSTAB" "$TARGET_FSTAB"
fi

# 3. Yazma işlemini diske (RAM) işle ve senkronize et
sync

echo "Done."
echo "Rebooting to recovery in 3 seconds..."
sleep 3
reboot recovery
