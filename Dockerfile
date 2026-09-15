FROM alpine:3.19

# Включаем штатный community репозиторий убиранием комментария '#'
RUN sed -i 's/^#\(.*community\)/\1/' /etc/apk/repositories && \
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
