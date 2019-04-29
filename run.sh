#!/bin/bash
# @Author: sqw
# @Date:   2019-04-29 17:44:45
# @Last Modified by:   sqw
# @Last Modified time: 2019-04-29 17:44:45


case $1 in 
	start)
		nohup ./system_job 2>&1 >> info.log 2>&1 /dev/null &
		echo "服务已启动..."
		sleep 1
	;;
	stop)
		killall system_Job
		echo "服务已停止..."
		sleep 1
	;;
	restart)
		killall system_Job
		sleep 1
		nohup ./system_job 2>&1 >> info.log 2>&1 /dev/null &
		echo "服务已重启..."
		sleep 1
	;;
	*) 
		echo "$0 {start|stop|restart}"
		exit 4
	;;
esac
