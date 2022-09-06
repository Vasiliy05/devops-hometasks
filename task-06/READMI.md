login: admin
password: admin

# Домашнее задание

- В репозитории `devops-hometasks` создайте директорию `task-06`
- C помощью Vagrant создайте виртуальную машину `jenkins.vm` основанную на Debian 10
- На машине jenkins.vm установите Jenkins. Для настройки Jenkins можно использовать роль [ansible-jenkins](https://github.com/emmetog/ansible-jenkins).
  - Необходимые плагины должны устанавливаться автоматически
  - Конфигурация системы должна производиться автоматически
  - Задача должна создаваться и настраиваться автоматически

# Домашнее задание

- Добавьте к Vagrantfile еще 3 машины:
  - nexus.vm
  - staging.vm
  - production.vm
- На машине nexus.vm установите Nexus3. Для установки и настройки используйте роль [nexus3-oss](https://github.com/ansible-ThoTeam/nexus3-oss).
  - Создается репозиторий для хранения артефактов сборки
  - Создается отдельный пользователь для загрузки данных в репозиторий
  - Создается отдельный пользователь для скачивания данных из репозитория
- На машинах staging.vm и production.vm создайте условия для установки и настройки службы word-cloud-generator

# Скрипт для сборки проекта

```bash
export GOPATH=$WORKSPACE/go
export PATH="$PATH:$(go env GOPATH)/bin"

go get github.com/tools/godep
go get github.com/smartystreets/goconvey
go get github.com/GeertJohan/go.rice/rice
go get github.com/wickett/word-cloud-generator/wordyapi
go get github.com/gorilla/mux

sed -i "s/1.DEVELOPMENT/1.$BUILD_NUMBER/g" static/version

GOOS=linux GOARCH=amd64 go build -o ./artifacts/word-cloud-generator -v 

md5sum artifacts/word-cloud-generator
gzip artifacts/word-cloud-generator
ls -l artifacts/
```
# Скрипт для развертывания приложения на сервере

```bash
sudo service wordcloud stop

curl -X GET "http://192.168.33.90:8081/repository/word-cloud-build/1/word-cloud-generator/1.$BUILD_NUMBER/word-cloud-generator-1.$BUILD_NUMBER.gz" -o /opt/wordcloud/word-cloud-generator.gz
ls -l /opt/wordcloud
gunzip -f /opt/wordcloud/word-cloud-generator.gz
chmod +x /opt/wordcloud/word-cloud-generator

sudo service wordcloud start
```

## systemd servie /etc/systemd/system/wordcloud.service

```bash
[Unit]
Description=Word Cloud Generator

[Service]
WorkingDirectory=/opt/wordcloud
ExecStart=/opt/wordcloud/word-cloud-generator
Restart=always

[Install]
WantedBy=multi-user.target
```

# Интеграционные тесты
```bash
res=`curl -s -H "Content-Type: application/json" -d '{"text":"ths is a really really really important thing this is"}' http://192.168.33.80:8888/version | jq '. | length'`
if [ "1" != "$res" ]; then
  exit 99
fi

res=`curl -s -H "Content-Type: application/json" -d '{"text":"ths is a really really really important thing this is"}' http://192.168.33.80:8888/api | jq '. | length'`
if [ "7" != "$res" ]; then
  exit 99
fi
```

# Полезные ссылки

- [Установка Jenkins](https://jenkins.io/doc/book/installing/)
- [Настройка агентов Jenkins](https://kamaok.org.ua/?p=2929)
- [Репозиторий приложения](https://github.com/wickett/word-cloud-generator)
- [Библиотека ролей для ansible](https://galaxy.ansible.com)
- [Роль для настройки jenkins](https://github.com/emmetog/ansible-jenkins)
- [Jenkins Wiki](https://wiki.jenkins.io/display/JENKINS/)
- [Nexus3 downloads](https://help.sonatype.com/repomanager3/product-information/download/download-archives---repository-manager-3)