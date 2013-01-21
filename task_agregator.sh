#!/bin/bash
#root_dir="."
source "./env/var.sh"

rm "$qeue_task_dir/*"
rm "$qeue_data_dir/*"

#в папке out каждого модуля
task_count=0
while [ 1 ]; do

for module_name in $(cat "$producers_list"); do
	current_module_dir="$modules_dir/$module_name"
	current_module_data_dir="$current_module_dir/$producer_data_dir"
	for data in $(ls "$current_module_data_dir")
	do
		let task_count++
		module_info="$current_module_dir/$producer_infofile"
		timestamp=`date +%s`
		task="$task_prefix.$timestamp.$module_name"
		task_info="$qeue_task_dir/$task"
		task_data="$qeue_data_dir/$task"
		data_file="$current_module_data_dir/$data"
		mv "$data_file" "$task_data"
		cp "$module_info" "$task_info"
		
	done	
done
echo "tasks added to qeue: $task_count"
sleep 0.1s
done
#забрать последние данные, добавить к ним описание
#положить в очередь, удалить данные 
