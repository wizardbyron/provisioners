# Provisioners

Provision scripts collection. The latest progress please refer to [Github Project](https://github.com/wizardbyron/provisioners/projects/1).

All the scripts are tested in the VM created by vagrant. Please update to latest box before provision your VM.

## Prerequisites

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://vagrantup.com/)

## Usage

1. Clone this repo via `git clone git@github.com:wizardbyron/provisioners.git`.
2. Customize your VM settings in `[Vagrantfile](/Vagrantfile)` and `[provision.sh](/provision.sh)`.
3. Create your VM by `vagrant up`.

## Utilities

* [Docker-CE](https://www.docker.com)

## Tips

Add vagrantbox from a mirror:

```shell
vagrant box add  https://mirrors.tuna.tsinghua.edu.cn/ubuntu-cloud-images/xenial/current/xenial-server-cloudimg-amd64-vagrant.box --name ubuntu/xenial64
```

## How to contribution

1. Create an issue in [Project Issues](https://github.com/wizardbyron/provisioners/issues) for your requirement.
2. Fork this repo and clone to your local.
3. Following the [convention] to write your scripts.
4. Commit code with your issue id in the front of your commit message.
5. Before push, please test your script in the Vagrant in onetouch.
6. Create a pull request in 1 commit you squashed.
7. Waiting for review and merge.

## LICENSE

[LICENSE](/LICENSE)
