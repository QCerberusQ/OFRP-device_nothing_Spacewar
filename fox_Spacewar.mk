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
OF_CLOCK_POS := 1

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
OF_QUICK_BACKUP_LIST := /boot;/data;

# -----------------------------------------------------------------------------
# System & Partition Tools (Advanced)
# -----------------------------------------------------------------------------
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1
# Dinamik partisyonlar (Super) için araçlar
OF_ENABLE_LPTOOLS := 1
OF_ENABLE_ALL_PARTITION_TOOLS := 1
OF_USE_DMCTL := 1
OF_DYNAMIC_FULL_SIZE := 6442450944
# -----------------------------------------------------------------------------
# Data Format & Encryption
# -----------------------------------------------------------------------------
# F2FS formatlarken sdcard hatasını önler
OF_UNBIND_SDCARD_F2FS := 1

# Format Data sonrası şifreleme meta verisini temizler (Bootloop önler - KRİTİK)
OF_WIPE_METADATA_AFTER_DATAFORMAT := 1

# Format sonrası MTP sorunlarını çözer
OF_BIND_MOUNT_SDCARD_ON_FORMAT := 1

# -----------------------------------------------------------------------------
# Extras
# -----------------------------------------------------------------------------
# Gelişmiş menü seçenekleri
OF_OPTIONS_LIST_NUM := 9
