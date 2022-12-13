#!/usr/bin/env bash

killall conky
sleep 2s
		
conky -c $HOME/.config/conky/Mimosa_DBlue/Mimosa.conf &> /dev/null &

exit
