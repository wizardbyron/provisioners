# Provisioners

A collection of provision scripts/configurations. 

All the scripts are tested in the VM created by vagrant.

The latest progress please refer to [Github Project](https://github.com/wizardbyron/provisioners/projects/1).

## Prerequisites

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://vagrantup.com/)

## Usage

1. Clone this repo via `git clone git@github.com:wizardbyron/provisioners.git`.
2. Customize your VM via `[Vagrantfile](/Vagrantfile)`.
3. Provision your VM by `vagrant up`.

## Platforms

* X86/64 Virtual Machines via VirtualBox
* AWS

## Linux Distros

* CentOS 7

## Facilities

* [Docker-CE](https://www.docker.com)
* [Jenkins](https://www.jenkins.io)
* [Kubernetes Master](https://kubernetes.io) with [Helm](https://helm.sh)

## Known Issues

1. If you found `umount /mnt` error. Please uninstall your current version VirtualBox Guest Plugin via `vagrant plugin uninstall vagrant-vbguest` and install earlier version `0.21` instead via `vagrant plugin install vagrant-vbguest --plugin-version 0.21`.


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
