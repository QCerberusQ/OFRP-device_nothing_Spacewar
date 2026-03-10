#
# fox_Spacewar.mk - OrangeFox Configuration for Nothing Phone (1)
#
# -----------------------------------------------------------------------------
# Screen Settings (Corrected for Camera Hole)
# -----------------------------------------------------------------------------
OF_SCREEN_H := 2400
OF_STATUS_H := 115
OF_STATUS_INDENT_LEFT := 165
OF_STATUS_INDENT_RIGHT := 48
OF_HIDE_NOTCH := 1
OF_CLOCK_POS := 0

# -----------------------------------------------------------------------------
# LED & FRP
# -----------------------------------------------------------------------------
OF_USE_GREEN_LED := 0
OF_ENABLE_FRP_ADDON := 1

# -----------------------------------------------------------------------------
# Backup Settings
# -----------------------------------------------------------------------------
OF_QUICK_BACKUP_LIST := /boot;/data;/metadata;/vendor_boot;/dtbo;
OF_SKIP_MULTIUSER_FOLDERS_BACKUP := 1

# -----------------------------------------------------------------------------
# System & Partition Tools
# -----------------------------------------------------------------------------
OF_NO_ADDITIONAL_MIUI_PROPS_CHECK := 1
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1
OF_ENABLE_LPTOOLS := 1
OF_ENABLE_ALL_PARTITION_TOOLS := 1
#OF_USE_DMCTL := 1
OF_KEEP_DM_PATH := 1
OF_CHECK_STAGED_OTA := 1

# -----------------------------------------------------------------------------
# Data Format & Encryption
# -----------------------------------------------------------------------------
OF_UNBIND_SDCARD_F2FS := 1
OF_FORCE_DATA_FORMAT_F2FS := 1
OF_WIPE_METADATA_AFTER_DATAFORMAT := 1
OF_BIND_MOUNT_SDCARD_ON_FORMAT := 1
OF_SKIP_DECRYPTED_ADOPTED_STORAGE := 1
OF_FORCE_CASEFOLDING := 1

# -----------------------------------------------------------------------------
# Extras
# -----------------------------------------------------------------------------
OF_UNMOUNT_SDCARDS_BEFORE_REBOOT := 1
OF_OPTIONS_LIST_NUM := 8
