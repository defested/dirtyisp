#!/bin/bash
# Name: dirtyisp.bash
# Author: Defested
# Purpose: To generate a lot of clutter in a user's internet history to obfuscate real activity. This is important now that ISPs can collect and sell users' internet activity.

#####Configuration####
logfile="/scripts/dirtyisp.log"
seed_list="/scripts/seed_list" #file with list of seed websites
max_loops="5" # the maximum number of nested for loops that will be used to walk the link tree
min_loops="2" # the minimum number of nested for loops
link_per="5"  # the percentage of links to be followed during the first loop. Each consecutive loop uses link_per divided by the loop number
max_sleep_time="50" # the maximum number of seconds to sleep before the seed list is re-read and run through
######################


echo "Script started: $(date)" >> $logfile
while true ; do
	list0=`cat $seed_list`
	loops=$((($RANDOM / (32768 / ($max_loops - $min_loops + 1) )) + $min_loops ))
	code=""
	echo "main loop began with $loops recursions at : $(date)" >> $logfile
	echo "using seed list:" >> $logfile
	for i in ${list0[@]} ; do echo $i; done >> $logfile
	for i in `seq 1 $loops`; do
		code+="for var$i in \${list$(($i-1))[@]} ; do if [ \$((((\$RANDOM / (32768 / (100 / $link_per)))*($i - 1) ) + 1 )) -ne 1 ] ; then continue ; fi ; for z in \`seq 1 $i\` ; do echo -n \"~\" >> $logfile ; done ; echo \"\$var$i\" >> $logfile; list$i=\`lynx -listonly -nonumbers -dump \$var$i | grep -ie \"^HTTP\" | grep -v \" \" 2> /dev/null\` ; "
	done
	code+=" done"
	for i in `seq 2 $loops`; do
		code+=" ; done"
	done
	eval $code > /dev/null 2>&1
	sleep=$((($RANDOM / (32768 / $max_sleep_time) ) + 1 ))
	echo "Sleeping for $sleep seconds" >> $logfile
	sleep $sleep
	echo "main loop ended: $(date)" >> $logfile
done
