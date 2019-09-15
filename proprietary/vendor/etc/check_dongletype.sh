#!/vendor/bin/sh

#prop_type=`getprop sys.asus.dongletype`
LOG_TAG="EC_HID"
type=`cat /sys/class/ec_hid/dongle/device/gDongleType`
event=`cat /sys/class/ec_hid/dongle/device/gDongleEvent`

echo "[$LOG_TAG] re-send dongle type $type, event $event uevent " > /dev/kmsg
echo $type > /sys/class/ec_hid/dongle/device/gDongleType
