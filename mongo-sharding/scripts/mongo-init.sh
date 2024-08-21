#!/bin/bash

###
# Инициализируем бд
###

docker exec -i router mongosh --port 27023 <<EOF
use somedb;
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i});

db.helloDoc.countDocuments();
exit();
EOF

