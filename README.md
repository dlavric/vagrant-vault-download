# Installs an Unix Vagrant machine with any version of Vault is specified

### Repository has been created using [this repo](https://github.com/kikitux/vault-dev-orcl).


## Prerequisites
- [X] [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [X] [Vagrant](https://www.vagrantup.com/downloads)

## Instructions

- Copy the repository and go to the repo path:

```shell
$ git clone git@github.com:dlavric/vagrant-vault-download.git
$ cd vagrant-vault-download
```

- Start Vagrant and provision it:

```shell
$ vagrant up
$ vagrant provision
```

- Check the version of Vault inside Vagrant VM:

```shell
$ vagrant ssh
$ vault version
```
