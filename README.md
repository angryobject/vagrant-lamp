# Simple Ubuntu-based LAMP stack for Vagrant

Provides basic LAMP configuration for Vagrant, using Ubuntu as guest os.

Intall: `vagrant up`.

The virtual machine is accessible on ip address `192.168.50.4`.

Files inside `conf` folder are copied to the guest os on startup, so if you change them you need to restart the guest os (`vagrant reload`) or provision it (`vagrant provision`).

You can access apache document root at `http://192.168.50.4`.

Apache supports virtual hosts out of the box. See the example configuration in `conf/apache/sites-available/vhosts` file.

The only thing you need to do on your local machine to access them is add this lines to your own (local) `hosts` file:

```
192.168.50.4       example.com
192.168.50.4       example.net
```

and then you can access them on urls `http://example.com/` and `http://example.net/` respectivelly.

And you can access mysql on the guest os from the host os:

```
mysql -uroot -proot --host=192.168.50.4
```

