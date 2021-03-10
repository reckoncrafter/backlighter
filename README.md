# backlighter
shell script for managing the backlight for laptops.

A script like this can be useful if your Linux :penguin: installation does not recognize your brightness adjustment keys, or you are using an external keyboard without brightness keys. Shortcuts can be bound to the commands in this script.

## Requirements
This script, by default assumes that your backlight brightness file is located at
`/sys/class/backlight/intel_backlight/brightness`.

If your brightness file is somewhere else, replace the `BACKLIGHT_DIR` variable at the top of the script.

This script also assumes that the maximum brightness allowed on your screen will be stored as **3484** in the `brightness` file.
This value can be adjusted in the `MAX_BR` variable.

## Usage
This script allows the user to change the brightness of their backlight within a range of 1-100, which is converted to be proportional to the range of 0 to the maximum brightness `MAX_BR`. The program takes two command line arguments.
- First, one of three operations:
  - `set` sets the brightness to the value entered.
  - `inc` increments the current brightness by the value entered.
  - `dec` decrements the current brightness by the value entered.
- Followed by the desired value.

e.g
```sh
$ ./backlighter.sh inc 10
```
