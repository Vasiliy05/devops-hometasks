# Домашнее задание

- В конфигурацию Puppet из прошлого домашнего задания внесите следующие изменения:
    - Установите модуль nginx
    - Настройте master.puppet в качестве reverse proxy для slave1.puppet и slave2.puppet.
-	Разработайте модуль Puppet, скачивающий и устанавливающий сервер Minecraft.
    - Добавьте к Vagrantfile ещё одну виртуальную машину с именем mineserver.puppet
    - Puppet на новой машине должен настраиваться автоматически при развертывании виртуальной машины с помощью Ansible
    - Вся настройка сервера Minecraft должна производиться модулем Puppet
    - Данные устанавливаемого сервера должны располагаться в директории `/opt/minecraft`
    - Сервер Minecraft должен скачиваться с [сайта](https://www.minecraft.net/ru-ru/download/server/).
    - Также необходимо [создать systemd-сервис](https://www.shellhacks.com/ru/systemd-service-file-example/) для автозапуска сервера.

# Полезные ссылки

- [Puppet Forge](https://forge.puppet.com)
- [Reverse Proxy](https://www.digitalocean.com/community/tutorials/how-to-configure-nginx-as-a-web-server-and-reverse-proxy-for-apache-on-one-ubuntu-18-04-server-ru)

