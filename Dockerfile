FROM debian:bookworm-slim

# Установка зависимостей и ocserv из базового репозитория
RUN apt-get update && apt-get install -y --no-install-recommends \
    ocserv \
    supervisor \
    iptables \
    iproute2 \
    ca-certificates \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Официальный скрипт установки ZeroTier для Debian
RUN curl -s https://install.zerotier.com | bash || true

# Создание каталогов под конфигурации и логи
RUN mkdir -p /var/log/supervisor /etc/zerotier-one /var/lib/zerotier-one /etc/ocserv

# Копирование супервизора и скрипта инициализации
COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
