# My Web App

## Варіант індивідуального завдання

N = 7  
V2 = (N % 2) + 1 = 2  
V3 = (N % 3) + 1 = 2  
V5 = (N % 5) + 1 = 3  

## Опис застосунку

Це веб-застосунок на Node.js з використанням PostgreSQL. Застосунок надає API для роботи із задачами та має health-check ендпоінти для перевірки стану сервера і бази даних.

## Середовище розробки та запуску

Використовується:
- Ubuntu
- Node.js
- npm
- PostgreSQL
- Nginx

## Запуск застосунку

Вручну:
npm install  
node app.js  

Через systemd:
sudo systemctl start mywebapp  

Перевірка:
sudo systemctl status mywebapp  

## API ендпоінти

GET /health/alive — перевірка роботи сервера  
GET /health/ready — перевірка бази даних  
GET /tasks — отримання списку задач  

## База даних

PostgreSQL

Запуск міграції:
psql mywebapp < migrations/init.sql  

## Розгортання

Автоматичне розгортання:
./setup.sh  

Скрипт виконує:
- встановлення пакетів
- створення користувачів
- створення бази даних
- запуск міграцій
- налаштування systemd
- запуск застосунку
- налаштування nginx

## Віртуальна машина

Базовий образ: Ubuntu (https://ubuntu.com/download)

Ресурси:
- CPU: 2 ядра
- RAM: 2GB
- Disk: 20GB

Додаткові налаштування: стандартна установка

## Доступ до ВМ

Console або SSH

Користувачі:
student  
teacher  
operator  
app  

## Nginx

Використовується як reverse proxy для перенаправлення запитів на Node.js застосунок (порт 3000).

## Тестування

Перевірка сервера:
curl http://localhost/health/alive  

Очікувано: OK  

Перевірка бази:
curl http://localhost/health/ready  

Перевірка API:
curl http://localhost/tasks  

Перевірка сервісів:
sudo systemctl status mywebapp  
sudo systemctl status nginx  

## Висновок

Було реалізовано Node.js веб-застосунок, інтеграцію з PostgreSQL, systemd сервіс, nginx reverse proxy, систему користувачів та автоматизацію розгортання через bash-скрипт.
