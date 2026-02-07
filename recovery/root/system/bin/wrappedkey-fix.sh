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
    # Spacewar için manuel testte onayladığımız kesin yol
    local V=/dev/block/bootdevice/by-name/vendor
    local VENDORDIR=/FFiles/temp/vendor_prop
    local VENDORFSTAB=/FFiles/temp/vendor_fstab

    mkdir -p $VENDORDIR

    # Mount denemesi - EROFS (modern ROM) veya otomatik fallback
    echo "OrangeFox: Vendor mount denemesi: $V" > /dev/kmsg
    mount -t erofs -o ro $V $VENDORDIR 2>/dev/null || mount -o ro $V $VENDORDIR 2>/dev/null

    # fstab dosyasını vendor içinden kopyala
    if [ -f "$VENDORDIR/etc/fstab.default" ]; then
        cp "$VENDORDIR/etc/fstab.default" $VENDORFSTAB
    elif [ -f "$VENDORDIR/etc/fstab.qcom" ]; then
        cp "$VENDORDIR/etc/fstab.qcom" $VENDORFSTAB
    fi

    # KRİTİK: Eğer vendor fstab okunamadıysa, mevcut fstab'a (wrappedkey) DOKUNMA!
    if [ ! -f "$VENDORFSTAB" ]; then
        echo "OrangeFox: HATA - Vendor fstab bulunamadi. Varsayilan korunuyor." > /dev/kmsg
        umount $VENDORDIR 2>/dev/null
        return
    fi

    # Şifreleme tipine göre fstab'ı yer değiştir
    if grep -qi "wrappedkey" $VENDORFSTAB; then
        echo "OrangeFox: wrappedkey TESPIT EDILDI." > /dev/kmsg
        cp /system/etc/recovery-wrappedkey.fstab /system/etc/recovery.fstab
    else
        echo "OrangeFox: wrappedkey BULUNAMADI (AOSP Modu)." > /dev/kmsg
        cp /system/etc/recovery-no-wrappedkey.fstab /system/etc/recovery.fstab
    fi

    # Temizlik
    umount $VENDORDIR 2>/dev/null
    rmdir $VENDORDIR 2>/dev/null
    rm -f $VENDORFSTAB
}

# Fonksiyonu çağır
check_vendor_wrappedkey

exit 0
