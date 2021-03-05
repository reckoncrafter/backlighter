# backlighter
shell script for managing the backlight for laptops.

## Requirements
This script, by default assumes that your backlight brightness file is located at
`/sys/class/backlight/intel_backlight/brightness`.

If your brightness file is somewhere else, replace the `BACKLIGHT_DIR` variable at the top of the script.

This script also assumes that the maximum brightness allowed on your screen will be stored as **3484** in the `brightness` file.
This value can be adjusted in the `MAX_BR` variable.
