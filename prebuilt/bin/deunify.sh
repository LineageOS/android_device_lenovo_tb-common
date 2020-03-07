#!/sbin/sh
baseband="";
for e in $(cat /proc/cmdline);
do
    tmp=$(echo $e | grep "androidboot.baseband" > /dev/null);
    if [ "0" == "$?" ]; then
        baseband=$(echo $e |cut -d":" -f1 |cut -d"=" -f2);
    fi
done

# Move variant-specific blobs
mv /system/system/vendor/firmware/variant/$baseband/a506_zap* /system/system/vendor/firmware/
mv /system/system/vendor/firmware/variant/$baseband/goodixfp* /system/system/vendor/firmware/
rm -rf /system/system/vendor/firmware/variant

# Remove telephony files for wifi variant
if [ "$baseband" == "apq" ]; then 
    rm -rf /system/system/app/datastatusnotification
    rm -rf /system/system/app/messaging
    rm -rf /system/system/app/QtiTelephonyService
    rm -rf /system/system/app/SecureElement
    rm -rf /system/system/app/SimAppDialog
    rm -rf /system/system/app/Stk
    rm -rf /system/system/priv-app/CarrierConfig
    rm -rf /system/system/priv-app/CellBroadcastReceiver
    rm -rf /system/system/priv-app/Dialer
    rm -rf /system/system/priv-app/TeleService
fi
