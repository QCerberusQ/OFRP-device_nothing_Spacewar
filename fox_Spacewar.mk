#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2025-2026 The OrangeFox Recovery Project
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
OF_FBE_METADATA_MOUNT_IGNORE := 1

# -----------------------------------------------------------------------------
# Data Format & Encryption (SAF VE RİSKSİZ)
# -----------------------------------------------------------------------------
OF_UNBIND_SDCARD_F2FS := 1
OF_WIPE_METADATA_AFTER_DATAFORMAT := 1
OF_SKIP_DECRYPTED_ADOPTED_STORAGE := 1
OF_FORCE_CASEFOLDING := 1

# -----------------------------------------------------------------------------
# Extras
# -----------------------------------------------------------------------------
OF_ENABLE_FRP_ADDON := 1
OF_UNMOUNT_SDCARDS_BEFORE_REBOOT := 1
OF_OPTIONS_LIST_NUM := 8

# -----------------------------------------------------------------------------
# Maintainer & Storage Tools
# -----------------------------------------------------------------------------
OF_MAINTAINER := QCerberusQ
OF_USE_DMCTL := 1

# -----------------------------------------------------------------------------
# Logging
# -----------------------------------------------------------------------------
OF_LOOP_DEVICE_ERRORS_TO_LOG := 1
OF_DONT_KEEP_LOG_HISTORY := 1

# -----------------------------------------------------------------------------
# Compression
# -----------------------------------------------------------------------------
OF_USE_LZ4_COMPRESSION := 1

# -----------------------------------------------------------------------------
# Security / Encryption
# -----------------------------------------------------------------------------
OF_DEFAULT_KEYMASTER_VERSION := 4.1
