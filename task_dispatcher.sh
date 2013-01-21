#!/bin/bash
#root_dir="."
source "./env/var.sh"

rm "$qeue_task_dir/*"
rm "$qeue_data_dir/*"

#в папке out каждого модуля
task_count=0
while [ 1 ]; do

for task in $(ls "$qeue_task_dir"); do
	let task_count++
	#echo $task
	for module_name in $(cat "$consumers_list"); do
		task_info_file="$qeue_task_dir/$task"
		current_module_dir="$modules_dir/$module_name"
		module_info_file="$current_module_dir/$consumer_infofile"
		module_info=`cat "$module_info_file"`
		task_info=`cat "$task_info_file"`
		if [ $module_info == $task_info ]; then
			current_module_data_dir="$current_module_dir/$consumer_data_dir"
			task_data_file="$qeue_data_dir/$task"
			data_file="$current_module_data_dir/$task"
			mv "$task_data_file" "$data_file"
			rm "$task_info_file"
			break
		fi
	done	
done
echo "tasks dispathed from qeue: $task_count"
sleep 0.1s
done
#забрать последние данные, добавить к ним описание
#положить в очередь, удалить данные 
