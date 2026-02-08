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
    # /FFiles yerine her zaman yazılabilir olan /tmp dizinini kullanıyoruz
    local V=/dev/block/bootdevice/by-name/vendor
    local VENDORDIR=/tmp/vendor_prop
    local VENDORFSTAB=/tmp/vendor_fstab
    
    mkdir -p $VENDORDIR

    # Dinamik bölümün (dm-4) hazır olması için gerçek bir bekleme döngüsü
    local timeout=0
    while [ ! -b "$V" ] && [ $timeout -lt 15 ]; do
        echo "OrangeFox: Vendor ($V) bekleniyor... ($timeout)" > /dev/kmsg
        sleep 1
        timeout=$((timeout+1))
    done

    # Bölüm hala yoksa çık
    [ ! -b "$V" ] && { echo "OrangeFox: KRITIK HATA - Vendor bulunamadi!" > /dev/kmsg; return; }

    # Mount denemesi
    if ! mount -t erofs -o ro $V $VENDORDIR 2>/dev/null; then
        mount -o ro $V $VENDORDIR 2>/dev/null
    fi

    # fstab tespiti
    local SOURCE_FSTAB=$(ls $VENDORDIR/etc/fstab.default $VENDORDIR/etc/fstab.qcom 2>/dev/null | head -n 1)

    if [ -f "$SOURCE_FSTAB" ]; then
        if grep -qi "wrappedkey" "$SOURCE_FSTAB"; then
            echo "OrangeFox: wrappedkey TESPIT EDILDI." > /dev/kmsg
            cp /system/etc/recovery-wrappedkey.fstab /system/etc/recovery.fstab
        else
            echo "OrangeFox: wrappedkey YOK (AOSP Modu)." > /dev/kmsg
            cp /system/etc/recovery-no-wrappedkey.fstab /system/etc/recovery.fstab
        fi
    else
        echo "OrangeFox: HATA - Vendor icinde fstab dosyasi bulunamadi!" > /dev/kmsg
    fi

    umount $VENDORDIR 2>/dev/null
    rm -rf $VENDORDIR
}

check_vendor_wrappedkey
exit 0
