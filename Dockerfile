FROM alpine:latest

# Установка необходимых пакетов
RUN apk add --no-cache \
    ocserv \
    zerotier-one \
    supervisor \
    iptables \
    iproute2 \
    ca-certificates

# Создаем папки под логи и конфиги
RUN mkdir -p /var/log/supervisor /etc/zerotier-one /var/lib/zerotier-one /etc/ocserv

# Копируем служебные файлы
COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
