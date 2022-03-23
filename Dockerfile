FROM alpine:3.15.1
ENV RSA_PRIVATE_KEY_NAME ssh.rsa
ENV PACKAGER_PRIVKEY /home/builder/${RSA_PRIVATE_KEY_NAME}
ENV REPODEST /packages
RUN mkdir alpine-glibc
RUN echo $(pwd)
COPY ./glibc-bin-${glibc_version}-0-x86_64.tar.gz ./glibc-bin-${glibc_version}-0-x86_64.tar.gz
WORKDIR alpine-glibc
RUN mv /glibc-bin-${glibc_version}-0-x86_64.tar.gz .
COPY ${directory}/alpine-glibc/APKBUILD .
COPY ${directory}/alpine-glibc/glibc.trigger .
COPY ${directory}/alpine-glibc/ld.so.conf .
COPY ${directory}/alpine-glibc/nsswitch.conf .
RUN apk --no-cache add alpine-sdk coreutils cmake abuild sudo && adduser -G abuild -g "Alpine Package Builder" -s /bin/ash -D builder \
  && echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && mkdir /packages \
  && chown builder:abuild /packages
COPY ${directory}/alpine-glibc/abuilder .
RUN chown -R builder /alpine-glibc
RUN mkdir /home/builder/package
RUN chown -R builder /home/builder
RUN chmod +x abuilder
USER builder
RUN abuild checksum
RUN abuild-keygen -a -i -n
RUN ./abuilder -r 
