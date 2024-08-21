#!/bin/bash

###
# Инициализация конфиг сервера:
###
docker exec -i configSrv mongosh --port 27020 <<EOF
rs.initiate(
  {
    _id : "config_server",
    configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27020" }
    ]
  }
)
EOF

###
# Инициализация шарда и его реплик №1:
###
docker exec -i shard1 mongosh --port 27021 <<EOF
rs.initiate(
  {
    _id : "shard1",
    members: [
      { _id : 0, host : "shard1:27021" },
      { _id : 1, host : "shard1-r1:27016" },
      { _id : 2, host : "shard1-r2:27017" }
    ]
  }
)
EOF

###
# Инициализация шарда и его реплик №2:
###
docker exec -i shard2 mongosh --port 27022 <<EOF
rs.initiate(
  {
    _id : "shard2",
    members: [
      { _id : 0, host : "shard2:27022" },
      { _id : 1, host : "shard2-r1:27018" },
      { _id : 2, host : "shard2-r2:27019" }
    ]
  }
)
EOF

###
# Инициализация роутера:
###
docker exec -i router mongosh --port 27023 <<EOF
sh.addShard( "shard1/shard1:27021");
sh.addShard( "shard2/shard2:27022");
sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )
EOF
