#!/system/bin/sh
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2022-2023 The OrangeFox Recovery Project
# Copyright (C) 2023 Maitreya Patni
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

# Deal with situations where the ROM doesn't support wrappedkey encryption;
# In such cases, remove the wrappedkey flag from the fstab file
#

#!/system/bin/sh

check_vendor_wrappedkey() {
    # A/B Slot desteği
    local SLOT=$(getprop ro.boot.slot_suffix)
    local V=/dev/block/bootdevice/by-name/vendor$SLOT
    local VENDORDIR=/FFiles/temp/vendor_prop
    local VENDORFSTAB=/FFiles/temp/vendor_fstab

    mkdir -p $VENDORDIR
    
    # Mount denemesi (Hata verirse dmesg'e yazması için 2>&1 ekledik)
    if ! mount -t erofs $V $VENDORDIR > /dev/null 2>&1; then
        mount -t ext4 $V $VENDORDIR > /dev/null 2>&1
    fi

    # Kritik: fstab.default yerine fstab.* aramak daha garantidir
    # Çünkü bazı ROM'larda fstab.qcom veya fstab.yupik olabilir
    local ACTUAL_FSTAB=$(ls $VENDORDIR/etc/fstab.* | head -n 1)
    
    if [ -f "$ACTUAL_FSTAB" ]; then
        cp "$ACTUAL_FSTAB" $VENDORFSTAB
    else
        # Eğer vendor fstab bulunamazsa varsayılan olarak no-wrappedkey seç (Güvenli liman)
        cp /system/etc/recovery-no-wrappedkey.fstab /system/etc/recovery.fstab
        umount $VENDORDIR
        return
    fi

    # Şifreleme kontrolü ve dosya değişimi
    if grep -q "wrappedkey" $VENDORFSTAB; then
        echo "OrangeFox: Wrappedkey algılandı, fstab güncelleniyor..." > /dev/kmsg
        cp /system/etc/recovery-wrappedkey.fstab /system/etc/recovery.fstab
    else
        echo "OrangeFox: Wrappedkey bulunamadı, fstab güncelleniyor..." > /dev/kmsg
        cp /system/etc/recovery-no-wrappedkey.fstab /system/etc/recovery.fstab
    fi

    # Temizlik
    umount $VENDORDIR
    rmdir $VENDORDIR
    rm -f $VENDORFSTAB
}

check_vendor_wrappedkey
exit 0
