#!/bin/sh

PORTS="11211 11212 11213 11214 11215 11216"

for p in $PORTS; do
	/usr/bin/gmetric --name memcached_"$p"_Current_Items --value `echo "stats" | nc -w 1 192.168.6.29 $p | grep "curr_items " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit curr_items
	/usr/bin/gmetric --name memcached_"$p"_Total_Items --value `echo "stats" | nc -w 1 192.168.6.29 $p | grep "total_items " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit total_items


	/usr/bin/gmetric --name memcached_"$p"_Bytes_Used --value `echo "stats" | nc -w 1 192.168.6.29 $p | grep " bytes " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit bytes


	/usr/bin/gmetric --name memcached_"$p"_Current_Connections --value `echo "stats" | nc -w 1 192.168.6.29 $p | grep "curr_connections " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit curr_connections
	/usr/bin/gmetric --name memcached_"$p"_Total_Connections --value `echo "stats" | nc -w 1 192.168.6.29 $p | grep "total_connections " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit total_connections


	/usr/bin/gmetric --name memcached_"$p"_Memory --value `echo "stats" | nc -w 1 192.168.6.29 $p | grep " bytes " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit bytes


	/usr/bin/gmetric --name memcached_"$p"_cmd_get --value `echo "stats" | nc -w 1 192.168.6.29 $p | grep "cmd_get " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit cmd_get
	/usr/bin/gmetric --name memcached_"$p"_cmd_set --value `echo "stats" | nc -w 1 192.168.6.29 $p | grep "cmd_set " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit cmd_set
	/usr/bin/gmetric --name memcached_"$p"_get_misses --value `echo "stats" | nc -w 1 192.168.6.29 $p | grep "get_misses " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit bytes


	/usr/bin/gmetric --name memcached_"$p"_bytes_read --value `echo "stats" | nc -w 1 192.168.6.29 $p | grep "bytes_read " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit bytes
	/usr/bin/gmetric --name memcached_"$p"_bytes_written --value `echo "stats" | nc -w 1 192.168.6.29 $p | grep "bytes_written " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit bytes
done
