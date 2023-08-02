#!/bin/bash

# Created on Jul 12, 2022 12:30:39 PM

# v1.0 by sVen Mueller
# v1.2 modified for SDT Skytap environment E.N. 08/01/2023
## This script runs requests for a set of URLs defined the the URLS.txt file
#This script is used for generating baseline traffic in the TPS-Based DoS Mitigation lab
# If you want to debug, change the first line to #!/bin/bash -x

function ctrl_c() {
   echo "** Trapped CTRL-C"
   kill -9 $SYN1_PID
   exit 1
}
clear
echo "Traffic Baselining"
echo
####################################
#
# $1    IP address
IP=$1
#
SRC_ADDR1=$(ip a show dev ens160 | grep inet | grep -v inet6 | awk -F'[/ ]+' '{print $3}' | sed -n 1p)

BASELINE='Please enter your type of baselining: '
options=("increasing" "Quit")
select opt in "${options[@]}"
do
        case $opt in
                "increasing")
                        while true; do
                                clear
                                echo "Hourly increasing traffic: $IP"
                                echo
                                for i in $(eval echo "{0..`date +%M`}")
                                        do
                                                 # curl -0 --interface $SRC_ADDR1 -s -o /dev/null -A "`shuf -n 1 clean_useragents.txt`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`shuf -n 1 urls.txt` && sleep 3   
                                                   curl -0 --interface $SRC_ADDR1 -s -o /dev/null -A "`shuf -n 1 clean_useragents.txt`"  -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`shuf -n 1 urls.txt` 
                                                done
                            
                        done
                ;;
                "Quit")
                        break
                ;;
        *) echo invalid option;;
    esac
done
