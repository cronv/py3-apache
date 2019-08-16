# Используем официальный образ Debian Buster Slim как базовый образ
FROM debian:buster-slim

# Устанавливаем необходимые пакеты и Apache
RUN apt-get update && apt-get install -y \
    nano \
    mc \
    apache2 \
    python3 \
    python3-pip \
    python3-psycopg2 \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем библиотеку Python для работы с MySQL
RUN pip3 install mysql-connector-python

# Конфигурируем Apache для запуска вашего приложения
RUN a2enmod cgi

# Добавление файлов настроек apache
COPY ./configs/ /etc/apache2/

# Удаление лишнего файла
RUN rm /var/www/html/index.html

# Установка домашней директории
WORKDIR /var/www/html

# Команда для запуска Apache в фоновом режиме
CMD ["apache2ctl", "-D", "FOREGROUND"]
