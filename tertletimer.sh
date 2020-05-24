#!/usr/bin/env bash

#Usage:
#tertletimer
#start a timer that counts down to the specified time.
#
#Options:
#-h hours
#-m minutes
#-s seconds
#-p print style
#-a absolute time at which to alert. Format: "2020-05-25 11:30:00". needs gnudate.

DURATION_HR=0
DURATION_MIN=0
DURATION_SEC=0
PRINT=4
ABSOLUTE=""

# Get hours minutes and seconds as input
OPTIND=1
while getopts "h:m:s:p:a:" opt; do
    case "$opt" in
    a)  ABSOLUTE=$OPTARG
	    ;;
    h)  DURATION_HR=$OPTARG
        ;;
    m)  DURATION_MIN=$OPTARG
        ;;
    s)  DURATION_SEC=$OPTARG
        ;;
    p)  PRINT=$OPTARG
	    ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
        ;;
    esac
done
# Font Setup
case $PRINT in
   1) oneline=true;;
   2) oneline=false; font="doom"; nlines=8;;
   3) oneline=false; font="colossal"; nlines=11;;
   4) oneline=false; font="standard"; nlines=6;;
   5) oneline=false; font="big"; nlines=8;;
   *) echo "Sorry, Not valid print option";;
esac
#font="doom" #"colossal"  #"big" #"barbwire" #"stampatello" #"standard"
#nlines=8  #11 #8 #8 #6 #6
if ! $oneline
then
	BASEDIR=$(dirname "$0")
	cat "$BASEDIR/ascii_tertle.txt"
   	printf "\n\n\n"
fi

# Clean up
function finish {
  printf "\n"
  tput cnorm # Restore cursor
  exit 0
}
trap finish EXIT

# Get total duration of timer in seconds
if ! [ "$ABSOLUTE" = "" ]
then

    if hash gdate 2>/dev/null; then
        DEADLINE=$( gdate -d "$ABSOLUTE" +%s)
    else
        DEADLINE=$( date -d "$ABSOLUTE" +%s)
    fi

    NOW=$(date +%s)
    DURATION=$(( $DEADLINE - $NOW ))
    if [ $DURATION -lt 0 ]
    then
        echo "The date you passed is in the past!"
        exit 0
    fi
else
    DURATION=$(( $DURATION_HR *3600 + $DURATION_MIN *60 + $DURATION_SEC))
fi

# hide cursor for the duration of the timer
tput civis

# get strating time
START=$(date +%s)


# Prepare the lines where figlet will print the time.
if ! $oneline
then
	#The following does not work:
	#for i in {1..$nlines}
	# so we need this syntax:
	for ((c=1; c<=$nlines; c++))
	do
		printf "\n"
	done
fi

# loop over time
while [ -1 ]; do
	# convert seconds
	NOW=$(date +%s)				# get time now in seconds
	DIF=$(( $NOW-$START ))			# compute diff in seconds
	ELAPSE=$(( $DURATION-$DIF ))		# compute elapsed time in seconds
	HR=$(( $ELAPSE/3600 ))
	MINS=$(( $ELAPSE/60 -($HR*60) ))			# convert to minutes... (dumps remainder from division)
	SECS=$(( $ELAPSE - ($MINS*60) - ($HR*3600) )) 	# ... and seconds

	#TIME_REMAINING="%0.2d:%0.2d:%0.2d" $HR $MINS $SECS

	# Clear the 6-line-display
	if ! $oneline
	then
		for ((c=1; c<=$nlines; c++))
		do
    			tput cuu1 # move cursor up by one line
    			tput el # clear the line
		done
	fi

	# Check if the count down is over
	if [ $HR == 0 ] && [ $MINS == 0 ] && [ $SECS == 0 ]	# if mins = 0 and secs = 0 (i.e. if time expired)
	then 					# blink screen
		if $oneline
		then
			printf "\r\e %0.2d:%0.2d:%0.2d" $HR $MINS $SECS
		else
			printf "%0.2d:%0.2d:%0.2d" $HR $MINS $SECS | figlet -f $font
		fi
		#printf "\r\e $MINS:0$SECS \n"

		# ALARM!
		for i in `seq 1 2`;    		# for i = 1:180 (i.e. 180 seconds)
		do
			# printing \7 is supposed to make the terminal flash and beep.
			#I have a feeling this depends heavily on the setup
			tput bel && sleep 0.33s && tput bel && sleep 0.33s && tput bel && sleep 0.33s
			# if not on macos, replace with sound-making command of choice
            if hash say 2>/dev/null; then
			    say beep
            else
                printf "\a\a\a\a\a\a"
            fi
			#brightness 0.2
			sleep 1
			#brightness 1
		done
		# FINISH SCRIPT
		break

	# else, timer is not done
	else
		#printf "\r\e %0.2d:%0.2d:%0.2d" $HR $MINS $SECS
		if $oneline
		then
			printf "\r\e %0.2d:%0.2d:%0.2d" $HR $MINS $SECS
		else
			printf "%0.2d:%0.2d:%0.2d" $HR $MINS $SECS | figlet -f $font
		fi

#		printf "%0.2d:%0.2d:%0.2d" $HR $MINS $SECS | figlet -f $font

		sleep 1  				# sleep 1 second
	fi					# end if
done	# end while loop


