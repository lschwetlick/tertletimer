# tertletimer

```
$ bash tertletimer.sh -a "23:30:00"
             ____
           /  ▀   \   ___
          /  ▀   ▀ \_/  ^\
        ««_▀___▀_____  --
          || || || ||


 _____    ___     ___ _____   _____  _____ 
|  _  |  /   |_  /   |  _  |_|  ___||____ |
| |/' | / /| (_)/ /| | |/' (_)___ \     / /
|  /| |/ /_| | / /_| |  /| |     \ \    \ \
\ |_/ /\___  |_\___  \ |_/ /_/\__/ /.___/ /
 \___/     |_(_)   |_/\___/(_)____/ \____/ 
```


This is a small ***Ter**minal **Timer*** utility script that counts down hours, minutes and seconds.
It prints the remaining time using figlet every second and alerts when 0 has been reached.

For a very neutral timer, pass `-p 1`.

```
$ bash tertletimer.sh -a "23:30:00" -p 1
04:35:48
```


## Usage:
tertletimer

start a timer that counts down to the specified time.

### Options:
- **-h** hours
- **-m** minutes
- **-s** seconds
- **-p** print style (font)
- **-a** absolute time at which to alert. Format: "2020-05-25 11:30:00". needs gnudate.

You should only pass either hours/minutes/seconds OR an absolute date.

I added the line to my `~/.bash_profile` to make the script globally accessible:
```
alias tertle="~/tertletimer/tertletimer.sh"
```


## Requirements
- figlet (and fonts, if you want to use the fancy print options. Otherwise pass `-p 1`)
- gdate (if you want to use the absolute date option)

## Example
```
bash tertletimer -m 5 -s 30
```
-> will count down 5 minutes and 30 seconds

```
bash tertletimer -a "19:30"
```
-> to 7:30 PM the same day.

