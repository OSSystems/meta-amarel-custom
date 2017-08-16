#!/bin/bash

# Manage GPIO set direction and value
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
dir=
value=

usage()
{
   	cat<<-EOF
   	GPIO Set GPIO direction and value
	Written by Ruslan Sirota <ruslan@amarel.net>

	Usage: ${progname} --gpio=<GPIO number> --dir=<direction> [--value=<value>]

	    --gpio		-- GPIO number.
	    --dir		-- GPIO direction.
			       Possible values: in, out.
	    --value		-- GPIO value in case of direction output.
			       Possible values: 0, 1.

	Examples:
	    ${progname} --gpio=94 --dir=in
		    -- configure GPIO 394 as input
	    ${progname} --gpio=95 --dir=out --value=1
		    -- configure GPIO 95 as output with value 1
	EOF

	exit 255
}

parse_args()
{
    opts="gpio:,dir:,value:"
    temp=`getopt -o h --long ${opts} -n ${progname} -- $@`
    [ $? -ne 0 ] && usage

    eval set -- "$temp"

    while :
    do
	case $1 in
	--gpio)			gpio=$2
				shift 2;;
	--dir)			dir=$2
				shift 2;;
	--value)		value=$2
				shift 2;;
	--)			shift; break 2 ;;  # exit loop
	* )			echo "unknown parameter $1"; return 1 ;;
	esac
    done

    # Check mandatory parameters.
    [ x${gpio} != x ] && [ x${dir} != x ] &&

    # Value required only for output (! input)
    ( ( ( [ ${gpio} -ge $iMX6_MIN_GPIO_NUM ] || [ ${gpio} -le $iMX6_MAX_GPIO_NUM ] ) || 
    ( [ ${gpio} -ge $GPIO_EXP_MIN ] || [ ${gpio} -le $GPIO_EXP_MAX ] ) ) &&
    ( [ x${dir} = xin ] || [ x${dir} = xout ] ) || 
    ( [ x${value} = x0 ] || [ x${value} = x1 ] ) )
}

set_gpio()
{
    if [ ! -d $GPIO_DEVICE/gpio${gpio} ]; then
	echo ${gpio} > $GPIO_DEVICE/export
    fi

    if [ -d $GPIO_DEVICE/gpio${gpio} ]; then
	# set direction if changed
	tmp_dir=$(cat $GPIO_DEVICE/gpio${gpio}/direction)
	if [ ${tmp_dir} != ${dir} ]; then
	    echo ${dir} > $GPIO_DEVICE/gpio${gpio}/direction
	fi
	
	#Set GPIO value
	if [ x${value} != x ] && [ ${dir} == out ]; then
	    echo ${value} > $GPIO_DEVICE/gpio${gpio}/value
	fi
	echo ${gpio} > $GPIO_DEVICE/unexport
	exit 0
    fi
    exit -1
}

main()
{
	parse_args $@ || usage

	set_gpio
}

main $@

