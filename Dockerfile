FROM alpine:3.19

# Включаем официальные репозитории main и community для Alpine 3.19
RUN sed -i 's/v[0-9]\.[0-9]/v3.19/g' /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.19/community" >> /etc/apk/repositories && \
    apk add --no-cache \
    ocserv \
    zerotier-one \
    supervisor \
    iptables \
    iproute2 \
    ca-certificates

# Создаем рабочие каталоги
RUN mkdir -p /var/log/supervisor /etc/zerotier-one /var/lib/zerotier-one /etc/ocserv

# Копируем конфигурационные файлы и entrypoint
COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
