#!/bin/bash

mongo -- "$MONGO_INITDB_DATABASE" <<EOF
    var database = db.getSiblingDB('$MONGO_INITDB_DATABASE');
    var user = '$(cat "$MONGO_INITDB_USERNAME")';
    var passwd = '$(cat "$MONGO_INITDB_PASSWORD")';
    database.createUser({user: user, pwd: passwd, roles: ["readWrite"]});
    database.createCollection('stories');
EOF
