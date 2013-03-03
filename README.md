# Simple Ubuntu-based LAMP stack for Vagrant

Provides basic LAMP configuration for Vagrant, using Ubuntu as guest os.

Intall: `vagrant up`.

Apache can be accessed on port `4567` on local machine (runs on port `80` on guest os).

MySQL can be accessed on port `4568` on local machine (runs on the same port on guest os).

Files inside `conf` folder are copied to the guest os on startup, so if you change them you need to restart the guest os (`vagrant reload`) or provision it (`vagrant provision`).

You can access apache document root at `http://localhost:4567`.

Also, Apache is ready for virtual hosts creation.

See the example configuration in `conf/apache/sites-avaliable/vhosts` as well as `conf/hosts` file.

The only thing you need to do on your local machine to access them is add this lines to your hosts file:

```
127.0.0.1       example.com
127.0.0.1       example.net
```

and then you can access them on `http://example.com:4567/` and `http://example.net:4567/`.

