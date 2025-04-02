##!/bin/bash
# v1.0 by sVen Mueller
# v2.0 by F5 Training Development Group
## This script creates dynamic baseline traffic. It must run for 
## approximately 5-10 minutes prior to starting juice__bados_attack.sh.
#
# If you want to debug, change the first line to #!/bin/bash -x
# to get the student_id number from SSH_CLIENT env variable
# if SSH_CLIENT is not set, the script will exit
#
# if [ -n "$SSH_CLIENT" ]; then
  # student_id=$(echo $SSH_CLIENT | cut -f3 -d.)
#else
 #  echo "SSH_CLIENT variable is not set, cannot continue, exiting"
  # exit 1
#fi
student_id=$(ipconfig.exe | grep IPv4 | head -1 | awk '{ print $NF }' | cut -d. -f3)
trap ctrl_c INT

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
IP=${1:-10.10.${student_id}.101}
#
# $2 Source Address 1
# $3 Source Address 2
# $4 Source Address 3
SRC_ADDR1=10.10.200.201
SRC_ADDR2=10.10.200.202
SRC_ADDR3=10.10.200.203
#
###################################
#IP=$1
#IP="10.10.${student_id}.100"
#if [ "$IP" == "" ]
# then
#        #echo -n "Enter Target IP as an Argument"
#        #exit
#fi

BASELINE='Please enter your type of baslining: '
options=("increasing" "alternate" "Quit")
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
                                                curl -0 --interface $SRC_ADDR1 -s -o /dev/null -A "`shuf -n 1 useragents_with_bots.txt`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`shuf -n 1 juice_urls.txt`
                                                curl -0 --interface $SRC_ADDR2 -s -o /dev/null -A "`shuf -n 1 useragents_with_bots.txt`"  http://$IP`shuf -n 1 juice_urls.txt`
                                                curl -0 --interface $SRC_ADDR3 -s -o /dev/null -A "`shuf -n 1 useragents_with_bots.txt`"  http://$IP`shuf -n 1 juice_urls.txt`
                                                #curl -0 -s -o /dev/null -A "`sort -R useragents_with_bots.txt | head -1`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`sort -R juice_urls.txt | head -1`
                                        done
                                #sleep 0.1
                        done    
                ;;
                "alternate")
                        while true; do
                                clear
                                echo "Hourly alternate traffic: $IP"
                                echo
                                #if (( {`date +%k` % 2} )); then
                                if (( `date +%k` % 2 )); then
                                        for i in {1..100};
                                                do
                                                        curl -0 --interface $SRC_ADDR1 -s -o /dev/null -A "`shuf -n 1 useragents_with_bots.txt`" -w "High:\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`shuf -n 1 juice_urls.txt`
                                                        curl -0 --interface $SRC_ADDR2 -s -o /dev/null -A "`shuf -n 1 useragents_with_bots.txt`"  http://$IP`shuf -n 1 juice_urls.txt`
                                                        curl -0 --interface $SRC_ADDR3 -s -o /dev/null -A "`shuf -n 1 useragents_with_bots.txt`"  http://$IP`shuf -n 1 juice_urls.txt`
                                                        #curl -0 -s -o /dev/null -A "`sort -R useragents_with_bots.txt | head -1`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`sort -R urls.txt | head -1`
                                                done
                                else
                                        for i in {1..50};
                                                do
                                                        curl --interface $SRC_ADDR1 -s -o /dev/null -A "`shuf -n 1 useragents_with_bots.txt`" -w "High:\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`shuf -n 1 juice_urls.txt`
                                                        curl --interface $SRC_ADDR2 -s -o /dev/null -A "`shuf -n 1 useragents_with_bots.txt`"  http://$IP`shuf -n 1 juice_urls.txt`
                                                        curl --interface $SRC_ADDR3 -s -o /dev/null -A "`shuf -n 1 useragents_with_bots.txt`"  http://$IP`shuf -n 1 juice_urls.txt`
                                                        #curl -0 -s -o /dev/null -A "`sort -R useragents_with_bots.txt | head -1`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`sort -R urls.txt | head -1`
                                                done
                                fi
                                #sleep 0.1
                                clear
                        done
                ;;
                "Quit")
                        break
                ;;
        *) echo invalid option;;
    esac
done
