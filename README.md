# Provisioners

Provisioners is a growing set of cloud solution provision scripts collection. You can customize and create solutions on any private or public cloud service.

The latest solution progress please refer to [Github Project](https://github.com/wizardbyron/provisioners/projects/1).

## Prerequisites

* PC with Internet (Seriously!!!)
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://vagrantup.com/)

## Usage

1. Clone this repo via `git clone git@github.com:wizardbyron/provisioners.git`.
2. Customize your solution via [Vagrantfile](/Vagrantfile) and solution scripts.
3. Provision your solution by `vagrant up`.
4. (Option) Add the VM to your `hosts` file.
5. Enjoy your solution.

## Platforms

* X86/64 Virtual Machines via VirtualBox
* Kubernetes
* Amazon Web Service
* Azure (TBD)
* Google Cloud Platform (TBD)
* Aliyun (TBD)
* Tencent Cloud (TBD)

## Linux Distros

* CentOS 7
* Ubuntu Focal64

## Facilities

Facility list please refer to [facilities/README.md](./facilities/README.md).

## Solutions

* [DevOps Platform](./solutions/devops/)
* [Kubernetes Platform](./solutions/k8s/)
* Microservice Platform (TBD)
* BigData(TBD)

## Workflow

1. Fork and clone this repo.
2. Provision & update solutions in solution scripts.
3. Extract & Push facility script from solution scripts.
4. Verify facility script in solution scripts.
5. Push solution script.

## Convention

1. Facilites scripts can be verified indivadually. 
2. Cross distro scripts are better than distro-specified scripts.
3. Docker is better than shell.
4. Docker-compose is better than docker in shell.

## Known Issues

### 1. `umount /mnt` error

Please uninstall your current version VirtualBox Guest Plugin by following command:

```vagrant plugin uninstall vagrant-vbguest```

Then install earlier version `0.21` by following command:

```vagrant plugin install vagrant-vbguest --plugin-version 0.21```

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
