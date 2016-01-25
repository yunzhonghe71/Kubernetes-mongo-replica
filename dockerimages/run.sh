#!/bin/bash
set -m


mongodb_cmd="mongod"
cmd="$mongodb_cmd  --noprealloc --smallfiles --replSet "rs0"  "
if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ "$JOURNALING" == "no" ]; then
    cmd="$cmd --nojournal"
fi

if [ "$OPLOG_SIZE" != "" ]; then
    cmd="$cmd --oplogSize $OPLOG_SIZE"
fi


$cmd --port 27017  & 
RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 2
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done
#HOST1=${MONGO_SERVICE_HOST}
#HOST2=${MONGO1_SERVICE_HOST}
#HOST3=${MONGO2_SERVICE_HOST}
echo "=> Waiting for confirmation of MongoDB service startup"

echo "=> ======================================================="
echo "configing ..........1/2"
echo $localhost  and  $HOST1  and $HOST2 and $HOST3
sleep 5
echo "=> ========================================:==============="
#if  [ "$COPY" == "yes" ]; then
#  mongo admin --eval "rs.initiate()" 
 mongo admin --eval "rs.initiate({_id:'rs0', members:[{_id:0, host:'$HOST1:27017', priority:"2"},{_id:1, host:'$HOST2:27017', priority:"0"},{_id:2, host:'$HOST3:27017', priority:"0"}]});"
#fi
echo "=> ======================================================="
echo "configing ..........2/2"
echo "=> ======================================================="
mongo admin --port 27017  --eval "while(true) {if (rs.status().ok) break;sleep(1000)};"
echo "=> ======================================================="
echo "config is all  done"
echo "=> ======================================================="

if [ ! -f /data/db/.mongodb_password_set ]; then
    /set_mongodb_password.sh
fi


fg
