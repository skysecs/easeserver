#!/bin/bash
# easeserver        Startup script for the easeserver Server
#
# chkconfig: - 85 12
# description: Open source detecting system
# processname: easeserver
# Date: 2015-04-12
# Version: 2.0.0
# Site: http://www.easeserver.org
# Author: easeserver group

. /etc/init.d/functions
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/node/bin

base_dir=$(dirname $0)

PROC_NAME="jumpsever"
lockfile=/var/lock/subsys/${PROC_NAME}


start() {
	jump_start=$"Starting ${PROC_NAME} service:"
	
	if [ -f $lockfile ];then	
		 echo "easeserver  is running..."
		 success "$jump_start"
	else
		 daemon python $base_dir/manage.py runserver 0.0.0.0:80 &>> /tmp/easeserver.log 2>&1 &
		 daemon python $base_dir/log_handler.py &> /dev/null 2>&1 &
         cd $base_dir/websocket/;daemon node index.js &> /dev/null 2>&1 &
         sleep 2

		 echo -n "$jump_start"
		 nums=0
         for i in manage.py log_handler.py index.js;do
             ps aux | grep "$i" | grep -v 'grep' &> /dev/null && let nums+=1 
         done

         if [ "x$nums" == "x3" ];then
            success "$jump_start"
            touch "$lockfile"
            echo
         else
            failure "$jump_start"
            echo
         fi
		
	 fi
		
	
}


stop() {

	echo -n $"Stopping ${PROC_NAME} service:"
	
	if [ -e $lockfile ];then
		ps aux | grep -E 'manage.py|log_handler.py|index.js' | grep -v grep | awk '{print $2}' | xargs kill -9 &> /dev/null
		ret=$?
		
		if [ $ret -eq 0 ]; then
			echo_success
			echo
            rm -f "$lockfile"
		else
			echo_failure
			echo
		fi
	else
			echo_success
			echo
		
	fi
		
	

}



restart(){
    stop
    start
}

# See how we were called.
case "$1" in    
  start)                
        start           
        ;;              
  stop)                         
        stop                    
        ;;                      

  restart)      
        restart         
        ;;              
            
  *)                    
        echo $"Usage: $0 {start|stop|restart}"
        exit 2          
esac                    