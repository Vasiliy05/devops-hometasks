# Домашнее задание

- В репозитории создайте директорию `task-09`
- В созданной директории создайте Dockerfile, создающий docker-образ, удовлетворяющий следующим требованиям:
  - Основан на debian:latest
  - При запуске выполняет Apache httpd, отображающий динамический сайт из прошлых домашних заданий
- В той же директории создайте скрипт dynamic.sh
  - запускающий докер-контейнер из вашего образа (имя образа - **`hometask-image`**) 
  - пробрасывающий порт 80 контейнера на порт 8080 хост-системы
- В той же директории создайте скрипт static.sh
  - запускающий докер-контейнер из вашего образа (имя образа - **`hometask-image`**)
  - пробрасывающий порт 80 контейнера на порт 8081 хост-системы
  - размещает файл `index.html` из вашей текущей директории в директории c кодом сайта.

# Домашнее задание

- Создайте в директории `task-09` файл Dockerfile.multi
- Созданный Dockerfile должен создавать один промежуточный образ:
  - Образ основан на golang:1.16
  - Получает исходный код проекта word-cloud-generator из https://github.com/Fenikks/word-cloud-generator.git
  - Выполняет сборку приложения с помощью команды `make`
- Созданный Dockerfile должен создавать итоговый образ 
  - Основаный на alpine:latest
  - Получающий исполняемый файл проекта word-cloud-generator из промежуточного образа
  - При запуске по умолчанию выполняюший приложение word-cloud-generator

# Полезные ссылки

- [Docker для начинающих](https://docker-curriculum.com/)
- [Создание образов](https://docs.docker.com/engine/reference/builder)
- [Серия статей про docker](https://habr.com/ru/company/ruvds/blog/438796/)
- [Dockerhub](https://hub.docker.com/)
- [CMD \& ENRTYPOINT](https://habr.com/ru/company/southbridge/blog/329138/)
- [Docker compose file specification](https://docs.docker.com/compose/compose-file/compose-versioning/)