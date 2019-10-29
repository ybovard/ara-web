FROM centos/nodejs-10-centos7

ENV LD_LIBRARY_PATH /opt/rh/rh-nodejs10/root/usr/lib64
ENV PATH /opt/rh/rh-nodejs10/root/usr/bin:/opt/app-root/src/node_modules/.bin/:/opt/app-root/src/.npm-global/bin/:/opt/app-root/src/bin:/opt/app-root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV NPM_CONFIG_PREFIX /opt/app-root/src/.npm-global
ENV NPM_RUN start

WORKDIR /opt

USER root

RUN yum update -y && yum upgrade && yum install -y git \
    && git clone https://github.com/ansible-community/ara-web \
    && npm update \
    && cd /opt/ara-web \
    && npm install

COPY config.json /opt/ara-web/public/config.json

WORKDIR /opt/ara-web
ENTRYPOINT [ "npm", "start" ] 
CMD ["--host", "127.0.0.1", "--port", "3000"]
