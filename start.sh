#!/bin/bash
set -u

# Downloading bootstrap file
cd /home/megacoin/bitcore-livenet/bin/mynode/data
if [ ! -d /home/megacoin/bitcore-livenet/bin/mynode/data/data/blocks ] && [ "$(curl -Is https://${WEB}/${BOOTSTRAP} | head -n 1 | tr -d '\r\n')" = "HTTP/1.1 200 OK" ] ; then \
        wget https://${WEB}/${BOOTSTRAP}; \
        tar -xvzf ${BOOTSTRAP}; \
        rm ${BOOTSTRAP}; \
fi

# Create script to downloading additional nodes file and add nodes after start with 'docker exec mec-insight-docker addnodes.sh'
echo "#!/bin/bash" > /usr/local/bin/new_config.sh
echo "mv /home/megacoin/bitcore-livenet/bin/mynode/data/megacoin.conf /home/megacoin/bitcore-livenet/bin/mynode/data/megacoin.conf.bak" >> /usr/local/bin/new_config.sh
echo "wget https://raw.githubusercontent.com/dalijolijo/MECinsight-docker/master/megacoin.conf -O /home/megacoin/bitcore-livenet/bin/mynode/data/megacoin.conf" >> /usr/local/bin/newConfig.sh
echo "supervisorctl restart megacoind" >> /usr/local/bin/new_config.sh
chmod 755 /usr/local/bin/new_config.sh

# Starting Supervisor Service
exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
