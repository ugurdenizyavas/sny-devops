#!/bin/bash
SCRIPTS_FOLDER="/opt/shared/scripts/"
LOG_FILE="${SCRIPTS_FOLDER}logs/`hostname`_deploy.log"
APPS_LIST_FILE="/opt/shared/scripts/app_list.txt"
APPS_DIR="/opt/shared/to_deploy/"

if [ -z "$1" ]; then
    echo "[ABORTED] Environment [dev, testqa, production] should be given as an argument"
    return
fi

#Read application list
while read -r line
do
	app_line=($line)
	app_name=${app_line[0]}
	app_script=${app_line[1]}

	app_file="$APPS_DIR$app_name"
	app_script_file="$SCRIPTS_FOLDER$app_script $1"

	if [ -f ${app_file} ]
	then
		echo "Checking new deployed file for $app_name"
		date_of_app_file=$(date +%s%N -r $app_file)
		date_of_now=$(date +%s%N)
		diff=$(($date_of_now- $date_of_app_file))
		age_of_file_in_min=$(($diff / $((60000000000))))
		echo "Age of file: $age_of_file_in_min"

		if [ $(($age_of_file_in_min - 5)) -lt 0 ]
        	then
			echo "New deployed file found: $app_name"
			sh "$app_script_file" >> "$LOG_FILE"
        	fi
	fi
done < "$APPS_LIST_FILE"
