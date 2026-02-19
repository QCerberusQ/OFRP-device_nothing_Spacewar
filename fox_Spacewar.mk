#
# fox_Spacewar.mk - OrangeFox Configuration for Nothing Phone (1)
# Pure Vendor Boot Edition
#

# -----------------------------------------------------------------------------
# Screen Settings (Corrected for Camera Hole)
# -----------------------------------------------------------------------------
OF_SCREEN_H := 2400
OF_STATUS_H := 115

# DÜZELTME: Eski çalışan yapıdaki değer (Kamera deliği için şart)
OF_STATUS_INDENT_LEFT := 165
OF_STATUS_INDENT_RIGHT := 48

OF_HIDE_NOTCH := 1
OF_CLOCK_POS := 0

# -----------------------------------------------------------------------------
# LED & FRP
# -----------------------------------------------------------------------------
OF_USE_GREEN_LED := 0

# frp
OF_ENABLE_FRP_ADDON := 1

# -----------------------------------------------------------------------------
# Backup Settings
# -----------------------------------------------------------------------------
# Hızlı yedekleme listesi
OF_QUICK_BACKUP_LIST := /boot;/data;/metadata;/vendor_boot;/dtbo;

# -----------------------------------------------------------------------------
# System & Partition Tools (Advanced)
# -----------------------------------------------------------------------------
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1
# Dinamik partisyonlar (Super) için araçlar
OF_ENABLE_LPTOOLS := 1
OF_ENABLE_ALL_PARTITION_TOOLS := 1
OF_USE_DMCTL := 1
OF_KEEP_DM_PATH := 1
OF_USE_TWRP_SAR_DETECT := 1
OF_CHECK_STAGED_OTA := 1

# -----------------------------------------------------------------------------
# Data Format & Encryption
# -----------------------------------------------------------------------------
# F2FS formatlarken sdcard hatasını önler
OF_UNBIND_SDCARD_F2FS := 1

# Format Data sonrası şifreleme meta verisini temizler (Bootloop önler - KRİTİK)
OF_WIPE_METADATA_AFTER_DATAFORMAT := 1

# Format sonrası MTP sorunlarını çözer
OF_BIND_MOUNT_SDCARD_ON_FORMAT := 1

# Hızlı yedekleme 
OF_SKIP_MULTIUSER_FOLDERS_BACKUP := 1

# -----------------------------------------------------------------------------
# Extras
# -----------------------------------------------------------------------------
# Gelişmiş menü seçenekleri
OF_OPTIONS_LIST_NUM := 9
