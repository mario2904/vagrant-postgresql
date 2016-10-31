# Simple way to Install and run PostgreSQL from a VM

## Requirements:
* [Vagrant](https://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)

## Download and Install:
```sh
git clone https://github.com/mario2904/vagrant-postgresql
cd vagrant-postgresql
vagrant up
```

## How to connect:
Your PostgreSQL database has been setup and can be accessed on your local machine on the forwarded port (default: 8000)
* Host: localhost
* Port: 8000
* Database: postgres
* Username: postgres
* Password: postgres

## Customize:
This only provides the bare basics to setup a database server. Here are some tips on how to customize.

##### PostgreSQL version
It currently uses version 9.4 but can be changed by modifying the line 8 of the file `bootstrap.sh`.
```sh
PG_VERSION=9.4
```
##### Change networking options
Open the `Vagrantfile` and look at line 17
```ruby
config.vm.network "forwarded_port", guest: 5432, host: 8000
```
This is one of many network configuration options, port forwarding. This line is forwarding the default postgreSQL port `5432` to the port `8000` of the host machine.

Vagrant exposes some high-level networking options for things such as forwarded ports, connecting to a public network, or creating a private network. To see more configuration options see: [Networking](https://www.vagrantup.com/docs/networking/)

##### Create custom User with Password and a Database
Open the `Vagrantfile` and uncomment line 21
```ruby
config.vm.provision :shell, path: "./customize.sh", :privileged => false
```
Look at the bash script and modify it to your liking.
By default it will create a user with password and a DB, all named the same a the environmental variable $USER (vagrant). It also creates a new table in the newly created DB. For more complex scripts take a look at: [PostgreSQL and bash Stuff](http://www.manniwood.com/postgresql_and_bash_stuff/)

## References:
* [Vagrant Docs](https://www.vagrantup.com/docs/)
* [PostgreSQL For Development With Vagrant](https://wiki.postgresql.org/wiki/PostgreSQL_For_Development_With_Vagrant)
* [PostgreSQL and bash Stuff](http://www.manniwood.com/postgresql_and_bash_stuff/)
