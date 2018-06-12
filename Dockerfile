FROM centos:latest

# Version 2.6.1
ENV VERSION 2.6.1

RUN yum -y update && \
	yum install -y bison flex gtk3-devel qt-devel gcc-c++ libpcap-devel c-ares-devel libsmi-devel gnutls-devel libgcrypt-devel krb5-devel GeoIP-devel ortp-devel portaudio-devel automake autoconf libtool && \
	wget https://2.na.dl.wireshark.org/src/wireshark-$VERSION.tar.xz && \
	tar xf wireshark-$VERSION.tar.xz && \
	cd wireshark-$VERSION && \
	./autogen.sh && \
	./configure --enable-setcap-install --disable-wireshark && \
	make && \
	make install && \
	yum clean -y all 

# Permissions	
RUN mkdir /data /data/wireshark /usr/bin/.libs && \
	chmod 777 /data/wireshark /usr/bin/.libs && \
	install -t /usr/bin/ wireshark-$VERSION/tshark && \
	install -t /usr/bin/ wireshark-$VERSION/dumpcap && \
        setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap && \
	chown root /usr/bin/dumpcap && \
	chmod u+s /usr/bin/dumpcap && \
	groupadd wireshark && \
        adduser --system --no-create-home -g wireshark wireshark && \
	chgrp wireshark /usr/bin/dumpcap /usr/bin/tshark && \
	chmod o-rx /usr/bin/dumpcap /usr/bin/tshark 
		
USER wireshark

WORKDIR /data/wireshark

ENV NETWORK_INTERFACE=eth0
ENV ARGS=""
CMD tshark -i $NETWORK_INTERFACE $ARGS -T ek > packets.json 
