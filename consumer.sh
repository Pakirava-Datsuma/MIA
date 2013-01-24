#!/bin/bash
source "./env/var.sh"
source "./env/func.sh"

#rm "$module_data_dir/*"
#rm "$consumer_data_dir/*"

driver_path="$1"
data_file="$2"
log_file="$data_file.log"
# переходим к драйверу
cd "$driver_path" 
# передаем ему входные данные
./driver "$2" &> "$log_file"
# проверяем код завершения
driver_error=$?
test driver_error > 0 && exit $driver_error
# если все в порядке - чистим нычки
rm "$data_file"
rm "$log_file"
exit 0
