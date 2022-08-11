# Домашнее задание

- В репозитории `devops-hometasks` создайте директорию `task-03`
- В поддиректории `01` создайте Vagrantfile, который конфигурирует виртуальную машину (одну) c помощью ansible
- Настройте виртуальную машину таким образом, чтобы на хост-машине при обращении на адрес http://localhost:8080 открывался статический HTML файл (**index.html**), а при обращении на адрес http://localhost:8081 - динамический сайт (**index.php**)

- В поддиректории `02` создайте Vagrantfile, который конфигурирует виртуальную машину (одну) c помощью ansible
- Внутри виртуальной машины настройте LXC-контейнеры, основанные на CentOS:
  - с установленным статическим сайтом
  - с установленным динамическим сайтом
- LXC-контейнеры также должны настраиваться с помощью ansible (один playbook, разные задачи для разных хостов)


# Полезные ссылки

- [Документация Ansible](https://docs.ansible.com/ansible/latest/)
- [Плейлист на YouTube](https://www.youtube.com/playlist?list=PLg5SS_4L6LYufspdPupdynbMQTBnZd31N)
- [Ansible для сетевых инженеров](https://ansible-for-network-engineers.readthedocs.io/ru/latest/)
- [Знакомство с Ansible](https://ealebed.github.io/posts/2015/\%D0\%B7\%D0\%BD\%D0\%B0\%D0\%BA\%D0\%BE\%D0\%BC\%D1\%81\%D1\%82\%D0\%B2\%D0\%BE-\%D1\%81-ansible-\%D1\%87\%D0\%B0\%D1\%81\%D1\%82\%D1\%8C-1-\%D0\%B2\%D0\%B2\%D0\%B5\%D0\%B4\%D0\%B5\%D0\%BD\%D0\%B8\%D0\%B5/)
- [Примеры ролей Ansible](https://rtfm.co.ua/ansible-roli-roles-primer/)
- [Библиотека ролей для ansible](https://galaxy.ansible.com)
- [Jinja templates](https://jinja.palletsprojects.com/en/2.11.x/templates/)

# Команды ansible
- `ansible-playbook -i inventory playbook.yaml`
- `ansible-galaxy collection install community.general`
- `ansible -i inventory all -m ping`
- `ansible -i inventory all -m apt -a "name=curl state=present" -b`
- `ansible -i inventory/hosts 192.168.50.5 -m setup`
- `ansible-vault encrypt inventory`
- `ansible-vault view inventory`
- `ansible-vault decrypt inventory`
- `ansible-vault edit inventory`
- `ansible-vault encrypt_string`
- `ansible-playbook -i inventory playbook.yaml --ask-vault-pass`
- `ansible-playbook -i inventory playbook.yaml --vault-password-file password.txt`
- `ansible-inventory --list -i ansible.hosts -y`
- `ansible-inventory --graph -i ansible.hosts`
- `ansible-playbook -i inventory playbook.yaml --tags "install_packages"`

