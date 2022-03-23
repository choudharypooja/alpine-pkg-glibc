FROM alpine:3.15.1
ENV RSA_PRIVATE_KEY_NAME ssh.rsa
ENV PACKAGER_PRIVKEY /home/builder/${RSA_PRIVATE_KEY_NAME}
ENV REPODEST /packages
RUN mkdir alpine-glibc
COPY ./glibc-bin-${bamboo.GLIBC_VERSION}-0-x86_64.tar.gz ./glibc-bin-${bamboo.GLIBC_VERSION}-0-x86_64.tar.gz
WORKDIR alpine-glibc
RUN mv /glibc-bin-${bamboo.GLIBC_VERSION}-0-x86_64.tar.gz .
COPY ${bamboo.working.directory}/alpine-glibc/APKBUILD .
COPY ${bamboo.working.directory}/alpine-glibc/glibc.trigger .
COPY ${bamboo.working.directory}/alpine-glibc/ld.so.conf .
COPY ${bamboo.working.directory}/alpine-glibc/nsswitch.conf .
RUN apk --no-cache add alpine-sdk coreutils cmake abuild sudo && adduser -G abuild -g "Alpine Package Builder" -s /bin/ash -D builder \
  && echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && mkdir /packages \
  && chown builder:abuild /packages
COPY ${bamboo.working.directory}/alpine-glibc/abuilder .
RUN chown -R builder /alpine-glibc
RUN mkdir /home/builder/package
RUN chown -R builder /home/builder
RUN chmod +x abuilder
USER builder
RUN abuild checksum
RUN abuild-keygen -a -i -n
RUN ./abuilder -r 
