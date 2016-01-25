echo "=> ======================================================="
echo "configing ..........1/3"
#var="{_id : 'rs0',members : [{_id : 0, host : "$HOST1:27017"}]}"
echo $localhost  and  $HOST1  and $HOST2
echo "172.18.226.192 mongomaster" >> /etc/hosts
sleep 5
echo "=> ========================================:==============="
# mongo  admin --port 27017  --eval "config = {_id : 'rs0',members : [{_id : 0, host : '$HOST1:27017'}]}"
#  mongo  admin --port 27017  --eval "config = { "_id": "rs0", "members" : [ { "_id" : 0, "host" : "172.18.248.87:27017" } ]}"
#mongo  admin --port 27017 --eval "rs.initiate()"
#mongo  admin --port 27017 --eval "rsconf = { _id: "rs0", members: [ { _id: 0, host: "172.18.226.192:27017" } ] }"
#mongo  admin --port 27017 --eval "rs.reconfig(rsconf, {force: true})"
echo "=> ======================================================="
echo "configing ..........2/3"
echo "=> ======================================================="
if  [ "$COPY" == "yes" ]; then
 # mongo admin  --port 27017 --eval "rs.add("$HOST1:$PORT1")"
 # mongo  admin --port 27017 --eval  "rs.initiate({_id : 'rs0',members : [{_id : 0, host : $HOST1:27017}]})"
mongo admin --eval "rs.initiate({_id:'rs0', members:[{_id:0, host:'$HOST1:27017', priority:"2"},{_id:1, host:'$HOST2:27017', priority:"0"}]});"
fi
#mongo admin --eval "db.runCommand({"replSetInitiate":{"_id":"blort","members":[{"_id":0,"host":"172.18.226.192:27017"}]})"
 # mongo  admin --port 27017 --eval "config={_id : 'rs0',members : [{_id : 0, host : 'localhost:27017'}]}"
#  mongo  admin --port 27017 --eval  "rs.initiate(
#{
#   "_id" : "rs0",
 #  "version" : 4,
  # "members" : [
   #   {
    #     "_id" : 1,
     #    "host" : "172.18.120.172:27017"
#      }
 #  ]
#}
#)"
 # mongo --port 27017 --eval "rs.add("$HOST2:$PORT2")"
echo "=> ======================================================="
echo "configing ..........3/3"
echo "=> ======================================================="
mongo admin --port 27017  --eval "while(true) {if (rs.status().ok) break;sleep(1000)};"
echo "=> ======================================================="
echo "config is all  done"
echo "=> ======================================================="

