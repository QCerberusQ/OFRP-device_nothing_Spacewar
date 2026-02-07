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
    local VENDORDIR=/FFiles/temp/vendor_prop
    mkdir -p $VENDORDIR

    # Nothing Phone (1) Dinamik Bölüm Yolu
    local V_PATH="/dev/block/bootdevice/by-name/vendor"

    echo "OrangeFox: Vendor mount denemesi: $V_PATH" > /dev/kmsg

    # EROFS/EXT4 Mount
    if ! mount -t erofs -o ro $V_PATH $VENDORDIR 2>/dev/null; then
        if ! mount -t ext4 -o ro $V_PATH $VENDORDIR 2>/dev/null; then
            echo "OrangeFox: HATA - Vendor mount basarisiz!" > /dev/kmsg
            cp /system/etc/recovery-no-wrappedkey.fstab /system/etc/recovery.fstab
            return
        fi
    fi

    # fstab dosyasını tespit et
    local FSTAB=$(ls $VENDORDIR/etc/fstab.* 2>/dev/null | head -n 1)
    
    # DEBUG: Hangi fstab dosyasının okunduğunu loglara yaz
    [ -n "$FSTAB" ] && echo "OrangeFox: Okunan kaynak fstab: $FSTAB" > /dev/kmsg

    if [ -f "$FSTAB" ] && grep -qi "wrappedkey" "$FSTAB"; then
        echo "OrangeFox: Wrappedkey TESPİT EDİLDİ -> Wrappedkey fstab aktif." > /dev/kmsg
        cp /system/etc/recovery-wrappedkey.fstab /system/etc/recovery.fstab
    else
        echo "OrangeFox: Wrappedkey BULUNAMADI -> AOSP/Lunaris fstab aktif." > /dev/kmsg
        cp /system/etc/recovery-no-wrappedkey.fstab /system/etc/recovery.fstab
    fi

    # Temizlik (Güvenli umount)
    umount $VENDORDIR 2>/dev/null
    rmdir $VENDORDIR 2>/dev/null
}

# Fonksiyonu çalıştır
check_vendor_wrappedkey

exit 0
