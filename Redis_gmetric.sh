#!/bin/sh

PORTS="6379 6380 1111 1112 1113 6381 6311 6312"
for p in $PORTS; do
	/usr/bin/gmetric --name Redis_"$p"_Commands --value `echo "info" | /usr/local/bin/redis-cli -h 192.168.6.29 -p $p | grep commands | awk -F":" '{ print $2 }' | tr -d "\r \n"` --type uint32 --unit commands
	/usr/bin/gmetric --name Redis_"$p"_Connections --value `echo "info" | /usr/local/bin/redis-cli -h 192.168.6.29 -p $p | grep connections | awk -F":" '{ print $2 }' | tr -d "\r \n"` --type uint32 --unit connections
	/usr/bin/gmetric --name Redis_"$p"_Memory --value `echo "info" | /usr/local/bin/redis-cli -h 192.168.6.29 -p $p | grep "used_memory:" | awk -F":" '{ print $2 }' | tr -d "\r \n"` --type uint32 --unit bytes
	/usr/bin/gmetric --name Redis_"$p"_Unsaved_Changes --value `echo "info" | /usr/local/bin/redis-cli -h 192.168.6.29 -p $p | grep "changes" | awk -F":" '{ print $2 }' | tr -d "\r \n"` --type uint32 --unit changes_since_last_save
done
