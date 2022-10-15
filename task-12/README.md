# Домашнее задание

- Перепишите конфигурацию из 11-го задания на Terraform, используя провайдер Kubernetes (замените тип сервиса LoadBalancer на NodePort)
- Все значения - порты, количество реплик, имя контейнера, докер образа и т.д. задайте через переменные
- Используйте backend Kubernetes для сохранения Terraform state
- Сохраните конфигурацию в github в каталоге task-12 используя Terraform провайдер github

# Полезные ссылки

- [Документация Terraform](https://www.terraform.io/docs)
- [Terraform провайдеры](https://registry.terraform.io/browse/providers)