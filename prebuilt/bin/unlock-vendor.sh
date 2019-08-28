#!/sbin/sh
#
# Unlock vendor partition
#

VENDOR=/dev/block/bootdevice/by-name/vendor
BLOCKDEV=/dev/block/mmcblk0

safeRunCommand() {
   cmnd="$@"
   $cmnd
   ERROR_CODE=$?
   if [ ${ERROR_CODE} != 0 ]; then
      printf "Error when executing command: '${command}'\n"
      exit ${ERROR_CODE}
   fi
}

if [ ! -e "$VENDOR" ]; then
    echo "Vendor partition does not exist!"

    # TODO
    # - check partition number of system partition
    # - get size of system partition
    # - calculate sizes of new system and vendor partitions

    #command="/tmp/sgdisk --info=24 $BLOCKDEV"
    #safeRunCommand $command

    # Delete system partition
    command="/tmp/sgdisk --delete=24 $BLOCKDEV"
    safeRunCommand $command

    # Recreate smaller system partiton
    command="/tmp/sgdisk --new=24:1054720:7346176 $BLOCKDEV"
    safeRunCommand $command

    # Change name of new system partition
    command="/tmp/sgdisk --change-name=24:system $BLOCKDEV"
    safeRunCommand $command

    # Create vendor partition
    command="/tmp/sgdisk --new=51:7346177:9443327 $BLOCKDEV"
    safeRunCommand $command

    # Change name of new vendor partition
    command="/tmp/sgdisk --change-name=51:vendor $BLOCKDEV"
    safeRunCommand $command
else
    echo "Vendor partiton found."
fi

exit 0
