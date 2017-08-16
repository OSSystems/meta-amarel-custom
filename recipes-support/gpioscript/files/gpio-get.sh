#!/bin/bash

# Manage GPIO get value
# Written by Ruslan Sirota

# set -e
# set -x

progname=`basename $0`

GPIO_DEVICE=/sys/class/gpio
iMX6_MIN_GPIO_NUM=0
iMX6_MAX_GPIO_NUM=224
GPIO_EXP_MIN=496
GPIO_EXP_MAX=511

gpio=

usage()
{
	cat<<-EOF
	GPIO get value
	Written by Ruslan Sirota <ruslan@amarel.net>

	Usage: ${progname} --gpio=<GPIO number>

	    --gpio		-- GPIO number

	Examples:
		${progname} --gpio=94 
	EOF

	exit 255
}

parse_args()
{
    opts="gpio:"
    temp=`getopt -o h --long ${opts} -n ${progname} -- $@`
    [ $? -ne 0 ] && usage

    eval set -- "$temp"

    while :
    do
	case $1 in
	--gpio)			gpio=$2
				shift 2;;
	--)			shift; break 2 ;;  # exit loop
	* )			echo "unknown parameter $1"; return 1 ;;
	esac
    done

    # Check mandatory parameters.
    [ x${gpio} != x ] &&
	
    # Value required only for output (! input)
    ( ( [ ${gpio} -ge $iMX6_MIN_GPIO_NUM ] || [ ${gpio} -le $iMX6_MAX_GPIO_NUM ] ) || 
    ( [ ${gpio} -ge $GPIO_EXP_MIN ] || [ ${gpio} -le $GPIO_EXP_MAX ] ) )
}

get_gpio_val()
{
    if [ ! -d $GPIO_DEVICE/gpio${gpio} ]; then
	echo ${gpio} > $GPIO_DEVICE/export
    fi

    if [ -d $GPIO_DEVICE/gpio${gpio} ]; then
	cat $GPIO_DEVICE/gpio${gpio}/value
    fi
}

main()
{
    parse_args $@ || usage

    get_gpio_val
}

main $@
