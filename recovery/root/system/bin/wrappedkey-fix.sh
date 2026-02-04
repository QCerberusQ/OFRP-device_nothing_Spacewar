#!/system/bin/sh
# wrappedkey-fix.sh
# Nothing Phone (1) / Spacewar
# Enable Wrapped Key support in kernel (Recovery side)

LOG=/dev/fscklogs/log/wrappedkey-fix.log
echo "[wrappedkey] start $(date)" >> $LOG

try_write() {
    NODE="$1"
    if [ -e "$NODE" ]; then
        echo 1 > "$NODE" 2>>$LOG
        if [ $? -eq 0 ]; then
            echo "[wrappedkey] enabled via $NODE" >> $LOG
            return 0
        else
            echo "[wrappedkey] write failed $NODE" >> $LOG
        fi
    else
        echo "[wrappedkey] node missing $NODE" >> $LOG
    fi
    return 1
}

# 1️⃣ Qualcomm ICE (generic)
try_write /sys/module/qti_ice/parameters/use_wrapped_key

# 2️⃣ Spacewar UFS controller (Snapdragon 778G+)
try_write /sys/devices/platform/soc/1d84000.ufshc/ice/use_wrapped_key

# 3️⃣ Fallback (bazı kernel varyantları)
for h in /sys/class/scsi_host/host*/use_wrapped_key; do
    try_write "$h"
done

echo "[wrappedkey] end $(date)" >> $LOG
exit 0
