#FROM balenalib/%%RESIN_MACHINE_NAME%%-debian
FROM balenalib/raspberrypi3-debian

RUN [ "cross-build-start" ]
RUN install_packages dnsmasq wireless-tools
RUN [ "cross-build-end" ]

WORKDIR /usr/src/app

RUN [ "cross-build-start" ]
RUN curl https://api.github.com/repos/balena-io/wifi-connect/releases/latest -s \
    #| grep -hoP 'browser_download_url": "\K.*%%RESIN_ARCH%%\.tar\.gz' \
    | grep -hoP 'browser_download_url": "\K.*armv7hf\.tar\.gz' \
    | xargs -n1 curl -Ls \
    | tar -xvz -C /usr/src/app/
RUN [ "cross-build-end" ]

COPY scripts/start.sh .

CMD ["bash", "start.sh"]
