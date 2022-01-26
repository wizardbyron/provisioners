# Provisioners

Provisioners is a growing set of cloud solution provision scripts collection. You can customize and create solution on any private or public cloud service.

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

## facility

Facility list please refer to [facility/README.md](./facility/README.md).

## solution

* [DevOps Platform](./solution/devops/)
* [Kubernetes Platform](./solution/k8s/)
* Microservice Platform (TBD)
* BigData(TBD)

## Workflow

1. Fork and clone this repo.
2. Provision & update solution in solution scripts.
3. Extract & Push facility script from solution scripts.
4. Verify facility script in solution scripts.
5. Push solution script.

## Convention

1. Facilites scripts can be verified indivadually.
2. Distro-crossed scripts are better than distro-specified scripts.
3. Docker is better than shell.
4. Docker-compose is better than docker in shell.
5. Follow [Terraform best practices](#terraform-best-practices)

## Terraform best practices

1. Don’t commit the `.tfstate` file
2. Configure a backend
3. Back up your state files
4. Keep your backends small
5. Use one state per environment
6. Setup backend state locking
7. Execute Terraform in an automated build
8. Manipulate state only through the commands
9. Use variables (liberally)
10. Use modules (only where necessary)

## Known Issues

### 1. `umount /mnt` error

Please uninstall your current version VirtualBox Guest Plugin by following command:

```vagrant plugin uninstall vagrant-vbguest```

Then install earlier version `0.21` by following command:

```vagrant plugin install vagrant-vbguest --plugin-version 0.21```

### 2. macOS Monterey and VirtualBox 6.1.28 (Fixed in VirtualBox 6.1.30)

Ref: https://github.com/hashicorp/vagrant/issues/12557#issuecomment-958183899:

To summarize this issue, there are currently issues with VirtualBox on macOS Monterey. There's three different things which are causing issues:

1. VMs cannot be started headless VB#20636
2. kexts not being loaded properly VB#20637
3. Cannot create network within given subnet VB#20626

For 1, the only way to workaround this is to enable the GUI within the provider configuration:

``` ruby
config.vm.provider :virtualbox do |vb|
  vb.gui = true
end
```

For 2, the kernel extensions can be loaded manually (which may be required after reboot):

``` Shell
sudo kextload -b org.virtualbox.kext.VBoxDrv;
sudo kextload -b org.virtualbox.kext.VBoxNetFlt;
sudo kextload -b org.virtualbox.kext.VBoxNetAdp;
sudo kextload -b org.virtualbox.kext.VBoxUSB;
```

For 3, the 6.1.28 release introduced a new restriction when creating networks which can be found here. PR #12564 adds validation to given addresses and returns back useful error message for how to add more ranges to the VirtualBox configuration.

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
