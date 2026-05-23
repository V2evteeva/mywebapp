# Laboratory Work 4 

## Student Information

Student: Вероніка Євтєєва  
Variant: 7  

---

# Project Description

Метою лабораторної роботи було розгортання веб-застосунку з використанням Terraform для автоматизації інфраструктури та Ansible для автоматизації конфігурації.

Система складається з двох віртуальних машин:

- worker-vm — nginx reverse proxy та web application
- db-vm — SQL database

---

# System Architecture


client
   |
   v
nginx (reverse proxy)
   |
   v
web application (worker-vm)
   |
   v
SQL database (db-vm)


---

# Repository Structure


mywebapp/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── cloud-init.yaml
│
├── ansible/
│   ├── inventory.ini
│   ├── Files/
│   │   ├── init.sql
│   │   └── mywebapp.service
│   │
│   ├── playbooks/
│   │   └── playbook.yml
│   │
│   └── templates/
│       └── nginx.conf.j2
│
├── app.js
├── nginx.conf
├── init.sql
├── mywebapp.service
└── README.md


---

# Terraform

Terraform використовується для опису інфраструктури та створення двох віртуальних машин.

## Run Terraform


cd terraform
terraform init
terraform plan
terraform apply


---

# Cloud-init

Cloud-init використовується для базового налаштування віртуальних машин.

Було створено користувачів:

- ansible
- teacher
- app
- operator

Також додано SSH-ключ для користувача ansible.

---

# Ansible

Ansible використовується для автоматичного налаштування сервісів після створення віртуальних машин.

## Inventory

Файл:


ansible/inventory.ini


містить групи:

- workers
- db

---

## Playbook

Файл:


ansible/playbooks/playbook.yml


виконує:

- встановлення nginx
- копіювання nginx configuration
- запуск nginx
- встановлення PostgreSQL
- копіювання init.sql
- копіювання mywebapp.service

---

# Run Ansible


ansible-playbook -i ansible/inventory.ini ansible/playbooks/playbook.yml


---

# Users

У системі створені користувачі:

| User | Purpose |
|---|---|
| ansible | автоматичне налаштування через Ansible |
| teacher | користувач для перевірки лабораторної |
| app | системний користувач для запуску застосунку |
| operator | користувач для керування web application та nginx |

---

# Gradebook

Було створено файл:


/home/student/gradebook


Вміст файлу:


7


---

# Technologies Used

- Terraform
- Ansible
- QEMU / Libvirt
- Ubuntu Server
- Nginx
- PostgreSQL
- Node.js

---

# Result

У ході виконання лабораторної роботи було:

- створено Terraform-конфігурацію для двох VM
- налаштовано cloud-init
- створено Ansible inventory
- написано playbook для конфігурації worker та db
- налаштовано nginx reverse proxy
- підготовлено конфігурацію PostgreSQL
- створено структуру автоматизованого розгортання застосунку

---

# Conclusion

Під час виконання лабораторної роботи було отримано практичні навички роботи з Terraform та Ansible для автоматизації розгортання інфраструктури та конфігурації серверів.

Було реалізовано архітектуру з двох віртуальних машин: окремо для веб-застосунку та окремо для бази даних. За допомогою Terraform описано інфраструктуру, а за допомогою Ansible підготовлено автоматичне налаштування сервісів.

У результаті підготовлено повну структуру проєкту для автоматизованого розгортання веб-застосунку відповідно до вимог лабораторної роботи.