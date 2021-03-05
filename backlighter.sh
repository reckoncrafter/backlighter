#!/bin/bash
BACKLIGHT_DIR='/sys/class/backlight/intel_backlight/brightness'
BL_OWNER=$(ls -l /sys/class/backlight/intel_backlight/brightness | awk '{print $3}')

## Do not accept empty paramater
if [ -z "$2" ] || [ -z "$1" ]; then
	echo "usage: backlighter 0-100"
	exit
fi

## Check ownership of /sys/class/backlight/intel_backlight/brightness, but only if the current user is not root
if [ $BL_OWNER != $USER ] && [ $USER != 'root' ]; then
	read -r -p "[backlighter]: You do not own the brightness configuration file. Change ownership to current user?[Y/n]: " opt
	case "$opt" in
		[yY][eE][sS]|[yY])
			sudo chown $USER $BACKLIGHT_DIR
			;;
		*)
			echo "Not changing file ownership. Please run as root."
			;;
	esac
fi
## Allow user to choose number 0-100, instead of 0-3484
let a=$2*3484/100
brightness=$(cat $BACKLIGHT_DIR)
## Defining Options...
function set() {
	if [ $a -lt 3485 ] && [ $a -gt -1 ]; then
		echo $a | tee $BACKLIGHT_DIR;
	else
		echo 3484 | tee $BACKLIGHT_DIR;
	fi
}
function inc() {
	let b=$brightness+$a
	if [ $b -lt 3484 ] && [ $a -gt -1 ]; then
		echo $b | tee $BACKLIGHT_DIR;
	elif [ $b -gt 3484 ]; then
		echo 3484 | tee $BACKLIGHT_DIR;
	elif [ $a -lt -1 ]; then
		echo "Error: Negative Integer";
	fi
}
function dec() {
	let b=$brightness-$a
	echo "result is "$b""
	if [ $b -lt 3484 ] && [ $a -gt -1 ] && [ $b -gt -1 ]; then
		echo $b | tee $BACKLIGHT_DIR;
	elif [ $b -gt 3484 ]; then
		echo 3484 | tee $BACKLIGHT_DIR;
	elif [ $a -lt -1 ]; then
		echo "Error: Negative Integer";
	elif [ $b -lt -1 ]; then
		echo 0 | tee $BACKLIGHT_DIR;
	fi
}
## Choosing Options
if [ "$1" = "set" ]; then
	set;
elif [ "$1" = "inc" ]; then
	inc;
elif [ "$1" = "dec" ]; then
	dec;
else
	echo "Error: operation "$1" not found";
fi
