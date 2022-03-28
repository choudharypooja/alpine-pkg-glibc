FROM alpine:3.15.0
ENV RSA_PRIVATE_KEY_NAME ssh.rsa
ENV PACKAGER_PRIVKEY /home/builder/${RSA_PRIVATE_KEY_NAME}
ENV REPODEST /packages
ARG glibc_version
ARG directory
RUN mkdir alpine-glibc
RUN echo $(pwd)
COPY ./glibc-bin-${glibc_version}-0-x86_64.tar.gz ./glibc-bin-${glibc_version}-0-x86_64.tar.gz
WORKDIR alpine-glibc
RUN mv /glibc-bin-${glibc_version}-0-x86_64.tar.gz .
COPY APKBUILD .
COPY glibc.trigger .
COPY ld.so.conf .
COPY nsswitch.conf .
RUN apk --no-cache add alpine-sdk coreutils cmake abuild sudo && adduser -G abuild -g "Alpine Package Builder" -s /bin/ash -D builder \
  && echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && mkdir /packages \
  && chown builder:abuild /packages
COPY abuilder .
RUN chown -R builder /alpine-glibc
RUN mkdir /home/builder/package
RUN chown -R builder /home/builder
RUN chmod +x abuilder
USER builder
RUN abuild checksum
RUN abuild-keygen -a -i -n
RUN ./abuilder -r 
