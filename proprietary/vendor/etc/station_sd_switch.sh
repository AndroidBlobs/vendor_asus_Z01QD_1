#!/vendor/bin/sh

LOG_TAG="station_sd_switch"
type=`getprop sys.asus.station.sd_power`
sdname=`ls /mnt/media_rw/`
disk_count=`cat /sys/module/usb_storage/parameters/disk_count`

echo "$LOG_TAG:[USB] disk_count = $disk_count" > /dev/kmsg
if [ "$type" == "1" ]; then
	echo "$LOG_TAG:[USB] station screen on" > /dev/kmsg
	echo 1 > /sys/class/ec_hid/dongle/device/sd_power
	echo 0 > /sys/devices/platform/soc/a600000.ssusb/SD_Transfer
elif [ "$type" == "2" ] && [ "$disk_count" = 0 ]; then
	echo "$LOG_TAG:[USB] station screen off" > /dev/kmsg
	if [ `ls /mnt/media_rw/|wc -l` = 1 ] ; then
		result=`umount /mnt/media_rw/$sdname`
		if [ $? = 0 ] ; then
			echo "Umount /mnt/media_rw/$sdname success"
			echo 0 > /sys/devices/platform/soc/a600000.ssusb/SD_Transfer
			if [ -z "$(ls -A /mnt/media_rw/$sdname)" ]; then
				rmdir /mnt/media_rw/$sdname
				echo 0 > /sys/class/ec_hid/dongle/device/sd_power
				echo "Remove sdcard mount point: $sdname"
				echo "After umount success, Station SD controller need power off/power on to revcover"
			else
				echo "This should not happened after umount success!!!"
			fi
		else
			echo "Umount /mnt/media_rw/$sdname fail!!!"
			echo 1 > /sys/devices/platform/soc/a600000.ssusb/SD_Transfer
		fi
	else
		echo "No unmount, folders under /mnt/media_rw:"
		echo "$sdname"
		echo 0 > /sys/class/ec_hid/dongle/device/sd_power
		echo 0 > /sys/devices/platform/soc/a600000.ssusb/SD_Transfer
	fi
fi
