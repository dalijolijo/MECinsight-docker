#!/bin/bash
set -u

# Downloading bootstrap file
cd /home/megacoin/bitcore-livenet/bin/mynode/data
if [ ! -d /home/megacoin/bitcore-livenet/bin/mynode/data/data/blocks ] && [ "$(curl -Is https://${WEB}/${BOOTSTRAP} | head -n 1 | tr -d '\r\n')" = "HTTP/1.1 200 OK" ] ; then \
        wget https://${WEB}/${BOOTSTRAP}; \
        tar -xvzf ${BOOTSTRAP}; \
        rm ${BOOTSTRAP}; \
fi

# Downloading and add additional nodes 
wget https://raw.githubusercontent.com/dalijolijo/MECinsight-docker/master/addnodes.conf -O /home/megacoin/bitcore-livenet/bin/mynode/data/addnodes.conf
cat /home/megacoin/bitcore-livenet/bin/mynode/data/addnodes.conf >> /home/megacoin/bitcore-livenet/bin/mynode/data/megacoin.conf

# Starting Supervisor Service
exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
