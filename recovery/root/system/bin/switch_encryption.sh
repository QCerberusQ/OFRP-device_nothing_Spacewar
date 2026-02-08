#!/system/bin/sh

VOLD_FSTAB="/system/etc/recovery-no-wrappedkey.fstab"
WRAPPED_FSTAB="/system/etc/recovery-wrappedkey.fstab"
TARGET_FSTAB="/system/etc/recovery.fstab"

echo "OrangeFox Encryption Switcher"
echo "------------------------------"

if grep -qiE "wrappedkey|wrapped-key" "$TARGET_FSTAB"; then
    echo "Current Mode : WRAPPEDKEY (Stock / crDroid)"
    echo "Switching to : VOLD (AOSP / Lunaris)"
    cp "$VOLD_FSTAB" "$TARGET_FSTAB"
else
    echo "Current Mode : VOLD (AOSP / Lunaris)"
    echo "Switching to : WRAPPEDKEY (Stock / crDroid)"
    cp "$WRAPPED_FSTAB" "$TARGET_FSTAB"
fi

echo "Done."
echo "Rebooting to recovery in 3 seconds..."
sleep 3
reboot recovery
