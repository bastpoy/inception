#!/bin/bash

CONF_FILE="/etc/redis/redis.conf"

echo "bind 0.0.0.0" >> $CONF_FILE
# echo "protection-mode no" >> $CONF_FILE

exec redis-server --protected-mode no
