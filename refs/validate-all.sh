#!/bin/bash

echo "Testing ietf-tcp-client (pyang)..."
pyang --ietf --max-line-length=69 -p ../ ../ietf-tcp-client\@*.yang

echo "Testing ietf-tcp-client (yanglint)..."
yanglint -p ../ ../ietf-tcp-client\@*.yang

echo "Testing ietf-tcp-server (pyang)..."
pyang --ietf --max-line-length=69 -p ../ ../ietf-tcp-server\@*.yang

echo "Testing ietf-tcp-server (yanglint)..."
yanglint -p ../ ../ietf-tcp-server\@*.yang

echo "Testing ietf-tcp-common (pyang)..."
pyang --ietf --max-line-length=69 -p ../ ../ietf-tcp-common\@*.yang

echo "Testing ietf-tcp-common (yanglint)..."
yanglint -p ../ ../ietf-tcp-common\@*.yang


echo "Testing ex-tcp-client.xml..."
name=`ls -1 ../ietf-tcp-client\@*.yang | sed 's/\.\.\///'`
sed 's/^}/container tcp-client { uses tcp-client-grouping; }}/' ../ietf-tcp-client\@*.yang > $name
yanglint -m -s $name -p ../ ex-tcp-client.xml
rm $name

echo "Testing ex-tcp-server.xml..."
name=`ls -1 ../ietf-tcp-server\@*.yang | sed 's/\.\.\///'`
sed 's/^}/container tcp-server { uses tcp-server-grouping; }}/' ../ietf-tcp-server\@*.yang > $name
yanglint -m -s $name -p ../ ex-tcp-server.xml
rm $name

echo "Testing ex-tcp-common.xml..."
name=`ls -1 ../ietf-tcp-common\@*.yang | sed 's/\.\.\///'`
sed 's/^}/container tcp-common { uses tcp-common-grouping; }}/' ../ietf-tcp-common\@*.yang > $name
yanglint -m -s $name ex-tcp-common.xml
rm $name

