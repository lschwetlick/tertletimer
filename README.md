# tertletimer

```
$ bash tertletimer -m 1
 _____  _____   _____  _____    _____  _____ 
|  _  ||  _  |_|  _  ||  _  |_ / __  \|  ___|
| |/' || |/' (_) |/' || |/' (_)`' / /'|___ \ 
|  /| ||  /| | |  /| ||  /| |    / /      \ \
\ |_/ /\ |_/ /_\ |_/ /\ |_/ /_ ./ /___/\__/ /
 \___/  \___/(_)\___/  \___/(_)\_____/\____/ 
                                             
```


This is a small ***Ter**minal **Timer*** utility script that counts down hours, minutes and seconds.
It prints the remaining time using figlet every second and alerts when 0 has been reached.

## Usage:
tertletimer

start a timer that counts down to the specified time.

### Options:
-h hours
-m minutes
-s seconds
-p print style (font)
-a absolute time at which to alert. Format: "2020-05-25 11:30:00". needs gnudate.

You should only pass either hours/minutes/seconds OR an absolute date.


## Example
```
bash tertletimer -m 5 -s 30
```
-> will count down 5 minutes and 30 seconds

```
bash tertletimer -a "19:30"
```
-> to 7:30 PM the same day.

