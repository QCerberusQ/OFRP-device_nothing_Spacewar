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
    local V=/dev/block/bootdevice/by-name/vendor
    local VENDORDIR=/FFiles/temp/vendor_prop
    local VENDORFSTAB=/FFiles/temp/vendor_fstab

    mkdir -p $VENDORDIR
    
    # Mount denemesi - Tip belirtmeden kernel'e bırakıyoruz (Orijinaldeki gibi)
    # Ama erofs desteği için -t parametresini yedekte tutuyoruz
    mount -o ro $V $VENDORDIR || mount -t erofs -o ro $V $VENDORDIR

    # Orijinaldeki gibi fstab.default dosyasına bakıyoruz
    if [ -f "$VENDORDIR/etc/fstab.default" ]; then
        cp "$VENDORDIR/etc/fstab.default" $VENDORFSTAB
    elif [ -f "$VENDORDIR/etc/fstab.qcom" ]; then
        cp "$VENDORDIR/etc/fstab.qcom" $VENDORFSTAB
    fi

    # Eğer dosya kopyalanamadıysa (mount başarısızsa) hiçbir şeyi değiştirme ve ÇIK
    if [ ! -f "$VENDORFSTAB" ]; then
        echo "OrangeFox: Vendor fstab bulunamadı, varsayılan fstab korunuyor." > /dev/kmsg
        umount $VENDORDIR
        return
    fi

    # Grep kontrolü (Büyük/Küçük harf duyarsız -i ekledik, daha garantidir)
    if grep -qi "wrappedkey" $VENDORFSTAB; then
        echo "OrangeFox: Wrappedkey TESPİT EDİLDİ." > /dev/kmsg
        cp /system/etc/recovery-wrappedkey.fstab /system/etc/recovery.fstab
    else
        echo "OrangeFox: Wrappedkey YOK (AOSP/Lunaris)." > /dev/kmsg
        cp /system/etc/recovery-no-wrappedkey.fstab /system/etc/recovery.fstab
    fi

    umount $VENDORDIR
    rmdir $VENDORDIR
    rm -f $VENDORFSTAB
}

check_vendor_wrappedkey
exit 0
