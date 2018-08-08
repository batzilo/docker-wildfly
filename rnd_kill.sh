set -e

while :;
do
	echo `date`
	x=$(($RANDOM % 2))
	echo -n "Brutally killing and restarting wfnode$x ... "
	docker container stop -t 0 wfnode$x >> /dev/null
	docker container rm wfnode$x >> /dev/null
	sleep 2
	./start_wfnode${x}.sh >> /dev/null
	echo "done!"
	echo "(Sleeping for 10sec ...)"
	sleep 10
	echo
	echo
done
