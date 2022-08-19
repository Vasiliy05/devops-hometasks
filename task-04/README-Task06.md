# Домашнее задание

- В репозитории `devops-hometasks` создайте директорию `task-04`
- В созданной директории создайте Vagrantfile, создающий 3 виртуальные машины, основанные на 'centos/8':
  - master.puppet - сервер Puppet
	- Должен быть установлен сервер Puppet
	- Должен быть установлен r10k. Его следует настроить на использование вашего puppet-репозитория.
  -	slave1.puppet, slave2.puppet
	- Должен быть установлен puppet-agent. Настройте его на master.puppet.
- Все настройки виртуальных машин должны быть реализованы с помощью провайдера ansible_local.
- Все настройки должны быть описаны в одном playbook, разделение действий по машинам должно происходить через inventory.

- Спомощью Puppet настройте сервер slave1.puppet для отображения static сайта из прошлых домашних заданий
- Спомощью Puppet настройте сервер slave2.puppet для отображения dynamic сайта из прошлых домашних заданий


# Конфиг утилиты r10k
```yaml
:cachedir: '/var/cache/r10k'

:sources:
  :my-org:
    remote: 'https://github.com/Fenikks/puppet-master-repo.git'
    basedir: '/etc/puppetlabs/code/environments'
```

# Полезные ссылки

- [Инструкция по установке Puppet](https://puppet.com/docs/puppet/7/server/install_from_packages.html#install-puppet-server-from-packages)
- [Зависимости между объектами](https://puppet.com/docs/puppet/7/lang_relationships.html)
 
# Команды puppet
- `sudo /opt/puppetlabs/puppet/bin/puppet agent -t`
- `puppetserver ca list --all`
- `puppetserver ca sign --certname slave1.puppet`
- `puppet config print`
- `puppet config print modulepath --section server --environment test`
- `r10k deploy environment -p`
- `puppet resource service mysql`
- `puppet parser validate site.pp`
- `facter processors`

# Пути puppet
- `/opt/puppetlabs/bin`
- `/opt/puppetlabs/puppet/bin`
- `/etc/sysconfig/puppetserver`
- `/etc/puppetlabs/puppet/puppet.conf`
- `/etc/puppetlabs/code/environments`