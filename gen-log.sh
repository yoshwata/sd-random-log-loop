#!/bin/bash
# https://unix.stackexchange.com/questions/500338/random-test-log-generator
# https://www.golinuxcloud.com/run-while-loop-until-specific-time-shell-bash/

# count=0
# hash='####################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################'

# while [ "$count" -lt 100000 ]
# do
#   case $((RANDOM % 3)) in
#         (0) status=OK
#                 ;;
#         (1) status=TEMP
#                 ;;
#         (2) status=PERM
#                 ;;
#   esac

#   case $((RANDOM % 4)) in
#         (0) data=\
# 'Amazon S3 (Simple Storage Service) is an online file storage web service offered by Amazon Web Services. Amazon S3 provides storage through web services interfaces (REST, SOAP, and BitTorrent).[1] Amazon launched S3, its first publicly available web service, in the United States in March 2006[2] and in Europe in November 2007.[3]'
#                 ;;
#         (1) data=\
# 'Amazon S3 is reported to store more than 2 trillion objects as of April 2013.[7] This is up from 102 billion objects as of March 2010,[8] 64 billion objects in August 2009,[9] 52 billion in March 2009,[10] 29 billion in October 2008,[5] 14 billion in January 2008, and 10 billion in October 2007.[11]'
#                 ;;
#         (2) data=\
# 'S3 uses include web hosting, image hosting, and storage for backup systems. S3 guarantees 99.9% monthly uptime service-level agreement (SLA),[12] that is, not more than 43 minutes of downtime per month.[13]'
#                 ;;
#         (3) data=\
# 'Details of S3'\''s design are not made public by Amazon, though it clearly manages data with an object storage architecture. According to Amazon, S3'\''s design aims to provide scalability, high availability, and low latency at commodity costs.'
#                 ;;
#   esac

#   part=$(
#     printf '%s|%s|%d|%s|%s' \
#         "20130101" \
#         $(printf '%02d:%02d:%02d' $((RANDOM % 3 + 9)) $((RANDOM % 60)) $((RANDOM % 60)) ) \
#         $((RANDOM % 2000 + 3000)) \
#         "$status" \
#         "$data"
#     )
#   printf '%.500s\n' "$part"'|'"$hash"
#   count=$((count + 1))
# done

runtime="2 minute"
endtime=$(date -ud "$runtime" +%s)

while [[ $(date -u +%s) -le $endtime ]]
do
    echo "Time Now: `date +%H:%M:%S`"
    random_ip=$(dd if=/dev/urandom bs=4 count=1 2>/dev/null | od -An -tu1 | sed -e 's/^ *//' -e 's/  */./g')
    random_size=$(( (RANDOM % 65535) + 1 ))

    current_date_time=$(date '+%d/%b/%Y:%H:%M:%S %z')

    echo "$random_ip - - [$current_date_time] \"GET /data.php HTTP/1.1\" 200 $random_size" | tee -a 'random_log'

    # sleep $[ ( $RANDOM % 10 )  + 1 ]s
    echo "Sleeping for 0.025 seconds"
    sleep 0.025
done
