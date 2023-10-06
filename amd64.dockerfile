# :: Header
  FROM 11notes/alpine:stable
  ENV APP_ROOT=/pwsh
  ENV APP_VERSION="7.2.10"
  ENV HOME=${APP_ROOT}
  ENV PSHOME=${APP_ROOT}
  ENV PSModulePath=${APP_ROOT}/lib

# :: Run
  USER root

  # :: update image
    RUN set -ex; \
      apk add --no-cache \
        ca-certificates \
        less \
        ncurses-terminfo-base \
        krb5-libs \
        libgcc \
        libintl \
        libssl1.1 \
        libstdc++ \
        userspace-rcu \
        zlib \
        icu-libs \
        lttng-ust; \
      apk --no-cache upgrade;

  # :: prepare image
    RUN set -ex; \
      mkdir -p ${APP_ROOT}/bin; \
      mkdir -p ${APP_ROOT}/lib; \
      mkdir -p /usr/local/share/powershell; \
      mkdir -p ${APP_ROOT}/.local/share/powershell;

  # :: install application
    RUN set -ex; \
      curl -L https://github.com/PowerShell/PowerShell/releases/download/v${APP_VERSION}/powershell-${APP_VERSION}-linux-alpine-x64.tar.gz -o /tmp/powershell.tar.gz; \
      tar zxf /tmp/powershell.tar.gz -C ${APP_ROOT}/bin; \
      chmod +x ${APP_ROOT}/bin/pwsh; \
      ln -s ${APP_ROOT}/bin/pwsh /usr/local/bin/pwsh; \
      ln -s ${APP_ROOT}/lib /usr/local/share/powershell/Modules; \
      ln -s ${APP_ROOT}/lib ${APP_ROOT}/.local/share/powershell/Modules;

  # :: copy root filesystem changes and add execution rights to init scripts
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin;

  # :: change home path for existing user and set correct permission
    RUN set -ex; \
      usermod -d ${APP_ROOT} docker; \
      chown -R 1000:1000 \
        ${APP_ROOT} \
        /usr/local/share/powershell/Modules;

# :: Volumes
  VOLUME ["${APP_ROOT}/lib"]

# :: Start
  USER docker
  ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]