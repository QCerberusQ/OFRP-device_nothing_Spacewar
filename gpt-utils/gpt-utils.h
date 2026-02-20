/*
 * Copyright (c) 2013,2016,2020 The Linux Foundation. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * * Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * * Redistributions in binary form must reproduce the above
 * copyright notice, this list of conditions and the following
 * disclaimer in the documentation and/or other materials provided
 * with the distribution.
 * * Neither the name of The Linux Foundation nor the names of its
 * contributors may be used to endorse or promote products derived
 * from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
 * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef __GPT_UTILS_H__
#define __GPT_UTILS_H__

#include <vector>
#include <string>
#include <map>

#ifdef __cplusplus
extern "C" {
#endif

#include <unistd.h>
#include <stdlib.h>
#include <stdint.h>
#include <limits.h>

/******************************************************************************
 * GPT HEADER DEFINES
 ******************************************************************************/
#define GPT_SIGNATURE               "EFI PART"
#define HEADER_SIZE_OFFSET          12
#define HEADER_CRC_OFFSET           16
#define PRIMARY_HEADER_OFFSET       24
#define BACKUP_HEADER_OFFSET        32
#define FIRST_USABLE_LBA_OFFSET     40
#define LAST_USABLE_LBA_OFFSET      48
#define PENTRIES_OFFSET             72
#define PARTITION_COUNT_OFFSET      80
#define PENTRY_SIZE_OFFSET          84
#define PARTITION_CRC_OFFSET        88

#define TYPE_GUID_OFFSET            0
#define TYPE_GUID_SIZE              16
#define PTN_ENTRY_SIZE              128
#define UNIQUE_GUID_OFFSET          16
#define FIRST_LBA_OFFSET            32
#define LAST_LBA_OFFSET             40
#define ATTRIBUTE_FLAG_OFFSET       48
#define PARTITION_NAME_OFFSET       56
#define MAX_GPT_NAME_SIZE           72

/******************************************************************************
 * AB RELATED DEFINES
 ******************************************************************************/
//Bit 48 onwards in the attribute field are the ones where we are allowed to
//store our AB attributes.
#define AB_FLAG_OFFSET (ATTRIBUTE_FLAG_OFFSET + 6)
#define GPT_DISK_INIT_MAGIC 0xABCD
#define AB_PARTITION_ATTR_SLOT_ACTIVE (0x1<<2)
#define AB_PARTITION_ATTR_BOOT_SUCCESSFUL (0x1<<6)
#define AB_PARTITION_ATTR_UNBOOTABLE (0x1<<7)
#define AB_SLOT_ACTIVE_VAL              0x3F
#define AB_SLOT_INACTIVE_VAL            0x0
#define AB_SLOT_ACTIVE                  1
#define AB_SLOT_INACTIVE                0
#define AB_SLOT_A_SUFFIX                "_a"
#define AB_SLOT_B_SUFFIX                "_b"

#define PTN_XBL                         "xbl"
#define PTN_XBL_CFG                     "xbl_config"
#define PTN_MULTIIMGOEM                 "multiimgoem"
#define PTN_MULTIIMGQTI                 "multiimgqti"

#define PTN_SWAP_LIST                   PTN_XBL, PTN_XBL_CFG, "sbl1", "rpm", "tz", "aboot", "abl", "hyp", "lksecapp", "keymaster", "cmnlib", "cmnlib32", "cmnlib64", "pmic", "apdp", "devcfg", "hosd", "keystore", "msadp", "mdtp", "mdtpsecapp", "dsp", "aop", "qupfw", "vbmeta", "vbmeta_system", "dtbo", "imagefv", "ImageFv", "multiimgoem", "multiimgqti", "vm-bootsys", "shrm", "cpucp", "uefisecapp", "featenabler", "qweslicstore"

#define AB_PTN_LIST PTN_SWAP_LIST, "boot", "system", "vendor", "odm", "modem", "bluetooth", "system_ext", "vendor_boot", "product"

#define BOOT_DEV_DIR    "/dev/block/bootdevice/by-name"

/******************************************************************************
 * HELPER MACROS
 ******************************************************************************/
#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

/******************************************************************************
 * TYPES
 ******************************************************************************/
enum boot_update_stage {
    UPDATE_MAIN = 1,
    UPDATE_BACKUP,
    UPDATE_FINALIZE
};

enum gpt_instance {
    PRIMARY_GPT = 0,
    SECONDARY_GPT
};

enum boot_chain {
    NORMAL_BOOT = 0,
    BACKUP_BOOT
};

struct gpt_disk {
    uint8_t *hdr;
    uint32_t hdr_crc;
    uint8_t *hdr_bak;
    uint32_t hdr_bak_crc;
    uint8_t *pentry_arr;
    uint8_t *pentry_arr_bak;
    uint32_t pentry_arr_size;
    uint32_t pentry_size;
    uint32_t pentry_arr_crc;
    uint32_t pentry_arr_bak_crc;
    char devpath[PATH_MAX];
    uint32_t block_size;
    uint32_t is_initialized;
};

/******************************************************************************
 * FUNCTION PROTOTYPES
 ******************************************************************************/
int prepare_boot_update(enum boot_update_stage stage);
struct gpt_disk* gpt_disk_alloc();
void gpt_disk_free(struct gpt_disk *disk);
int gpt_disk_get_disk_info(const char *dev, struct gpt_disk *disk);
uint8_t* gpt_disk_get_pentry(struct gpt_disk *disk, const char *partname, enum gpt_instance instance);
int gpt_disk_update_crc(struct gpt_disk *disk);
int gpt_disk_commit(struct gpt_disk *disk);
int gpt_utils_is_ufs_device();
int gpt_utils_set_xbl_boot_partition(enum boot_chain chain);
int gpt_utils_get_partition_map(std::vector<std::string>& partition_list, std::map<std::string,std::vector<std::string>>& partition_map);

#ifdef __cplusplus
}
#endif

#endif /* __GPT_UTILS_H__ */
