FROM alpine:latest

# Включаем репозитории main и community, затем устанавливаем пакеты
RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main" > /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories && \
    apk add --no-cache \
    ocserv \
    zerotier-one \
    supervisor \
    iptables \
    iproute2 \
    ca-certificates

# Создаем директории
RUN mkdir -p /var/log/supervisor /etc/zerotier-one /var/lib/zerotier-one /etc/ocserv

# Копируем конфиги и скрипт
COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
