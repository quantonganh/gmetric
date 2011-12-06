#!/bin/sh

IP="192.168.6.29"
PORTS="1979 1980 1981 1983 1985 2001 2002 19807 19810 19811 19812 19813"

for p in $PORTS; do
	/usr/bin/gmetric --name TokyoTyrant_"$p"_loadavg --value `/usr/local/tokyotyrant/bin/tcrmgr inform -port $p -st $IP | grep "loadavg" | awk '{ print $2 }'` --type float --unit loadavg
	/usr/bin/gmetric --name TokyoTyrant_"$p"_memsize --value `/usr/local/tokyotyrant/bin/tcrmgr inform -port $p -st $IP | grep "memsize" | awk '{ print $2 }'` --type int32 --unit bytes
	/usr/bin/gmetric --name TokyoTyrant_"$p"_rusage_user --value `echo "stats" | nc -w 1 $IP $p | grep "rusage_user " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit seconds
	/usr/bin/gmetric --name TokyoTyrant_"$p"_rusage_system --value `echo "stats" | nc -w 1 $IP $p | grep "rusage_system " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit seconds
	/usr/bin/gmetric --name TokyoTyrant_"$p"_cmd_set --value `echo "stats" | nc -w 1 $IP $p | grep "cmd_set " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit cmd_set
	/usr/bin/gmetric --name TokyoTyrant_"$p"_cmd_set_misses --value `echo "stats" | nc -w 1 $IP $p | grep "cmd_set_misses " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit cmd_set_misses
	/usr/bin/gmetric --name TokyoTyrant_"$p"_cmd_delete --value `echo "stats" | nc -w 1 $IP $p | grep "cmd_delete " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit cmd_delete
	/usr/bin/gmetric --name TokyoTyrant_"$p"_cmd_delete_misses --value `echo "stats" | nc -w 1 $IP $p | grep "cmd_delete_misses " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit cmd_delete_misses
	/usr/bin/gmetric --name TokyoTyrant_"$p"_cmd_get --value `echo "stats" | nc -w 1 $IP $p | grep "cmd_get " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit cmd_get	
	/usr/bin/gmetric --name TokyoTyrant_"$p"_cmd_get_misses --value `echo "stats" | nc -w 1 $IP $p | grep "cmd_get_misses " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit cmd_get_misses
	/usr/bin/gmetric --name TokyoTyrant_"$p"_curr_items --value `echo "stats" | nc -w 1 $IP $p | grep "curr_items " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit curr_items
	/usr/bin/gmetric --name TokyoTyrant_"$p"_total_items --value `echo "stats" | nc -w 1 $IP $p | grep "total_items " | awk '{ print $3 }' | tr -d "\r \n"` --type int32 --unit total_items
done
