#!/bin/bash
#./log_check.sh | tee log_check_$(date +'%Y_%m_%d_%H_%M_%S').txt

LOG_DIR=/var/log
LOG_OLD=1
#ERROR_PATERN=("FATAL" "CRITICAL" "ERROR" "WARNING")
ERROR_PATERN=("FATAL" "CRITICAL" "ERROR")

LOG_FILES=$(find $LOG_DIR/ -name *.log -mtime -$LOG_OLD)
echo -e "\n======================================================"
echo -e "======Report generated at $(date +'%Y-%m-%d %H:%M:%S')======"
echo -e "======================================================"
for LOG_FILE in $LOG_FILES; do
    for PATERN in ${ERROR_PATERN[@]}; do
        ERR_NUMBER=$(grep -c $PATERN $LOG_FILE)
        if [ "$ERR_NUMBER" -gt 0 ]; then
            echo -e "\n======================================================"
            echo -e "\n->Number of $PATERN in the file $LOG_FILE: $ERR_NUMBER"
            echo -e "\n->List of $PATERN from the file $LOG_FILE" 
            grep $PATERN $LOG_FILE
            echo -e "\n======================================================"
        fi
    done
done
