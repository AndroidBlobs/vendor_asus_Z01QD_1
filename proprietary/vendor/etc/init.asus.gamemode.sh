#!/vendor/bin/sh
game_mode_type=`getprop sys.asus.gamingtype`
rotation_type=`getprop sys.screen.rotation`

if [ "$game_mode_type" = "1" ];then
	if [ "$rotation_type" = "90" ];then
		echo 0 > /sys/bus/i2c/devices/i2c-4/4-0038/checkG270_game_mode
		echo 1 > /sys/bus/i2c/devices/i2c-4/4-0038/checkG90_game_mode
		echo "[Touch]in gaming mode and rotation = 90" >> /dev/kmsg
	elif [ "$rotation_type" = "270" ];then
		echo 0 > /sys/bus/i2c/devices/i2c-4/4-0038/checkG90_game_mode
		echo 1 > /sys/bus/i2c/devices/i2c-4/4-0038/checkG270_game_mode
		echo "[Touch]in gaming mode and rotation = 270" >> /dev/kmsg
	else
		echo "[Touch]in gaming mode but not rotation " >> /dev/kmsg
	fi
else
	echo 0 > /sys/bus/i2c/devices/i2c-4/4-0038/checkG90_game_mode
	echo 0 > /sys/bus/i2c/devices/i2c-4/4-0038/checkG270_game_mode
	echo "[Touch]not in gaming mode" >> /dev/kmsg
fi



