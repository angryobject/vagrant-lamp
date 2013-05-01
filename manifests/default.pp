# Basic Puppet LAMP manifest for Ubuntu

class lamp {

  $ip = "192.168.50.4"
  $apache2 = ["apache2"]
  $mysql = ["mysql-server", "libapache2-mod-auth-mysql"]
  $php = ["php5", "libapache2-mod-php5", "php5-mysql", "php5-mcrypt", "php5-gd", "php5-imagick", "php5-curl", "php5-tidy"]


    # Update

  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

    # Install apache

  package { $apache2:
    ensure => present
  }

    # Install mysql

  package { $mysql:
    ensure => present,
    require => Package[$apache2]
  }

    # Install php

  package { $php:
    ensure => present,
    require => [Package[$apache2], Package[$mysql]]
  }

    # Run apache

  service { "apache2":
    ensure => running,
    require => Package[$apache2]
  }

    # Run mysql

  service { "mysql":
    ensure    => running,
    require   => Package[$mysql]
  }

    # Change mysql root password

  exec { "mysql password":
    command => "/usr/bin/mysqladmin -u root password root || /bin/true",
    require => Service["mysql"]
  }

    # Grant mysql privileges

  exec { "mysql privileges":
    command => "/usr/bin/mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON *.* TO root@'$ip' IDENTIFIED BY 'root';\" &&
                /usr/bin/mysql -uroot -proot -e \"GRANT ALL PRIVILEGES ON *.* TO root@'192.168.50.1' IDENTIFIED BY 'root';\"",
    require => [Service["mysql"], Exec["mysql password"]]
  }

    # Link apache document root to host www folder

  file { "/var/www":
    ensure => link,
    target => "/vagrant/www",
    notify => Service["apache2"],
    force  => true
  }

    # Declare virtual hosts

  file { "/etc/apache2/sites-available/vhosts":
    ensure => present,
    source  => "/vagrant/conf/apache/sites-available/vhosts",
    require => [Package[$apache2], File["/var/www"]],
    notify => Service["apache2"],
    force  => true
  }

  ### Default (root) vhost configuration (if needed)
  #
  # file { "/etc/apache2/sites-available/default":
  #   ensure => present,
  #   source  => "/vagrant/conf/apache/sites-available/default",
  #   require => [Package[$apache2], File["/var/www"]],
  #   notify => Service["apache2"],
  #   force  => true
  # }
  ###

    # Enable virtual hosts

  exec { "apache vhosts":
    command => "/usr/sbin/a2ensite vhosts",
    require => [Package[$apache2], File["/etc/apache2/sites-available/vhosts"]],
    notify => Service["apache2"]
  }

    # Copy mysql config

  file { "/etc/mysql/my.cnf":
    ensure => present,
    source  => "/vagrant/conf/mysql/my.cnf",
    require => Package[$mysql],
    notify => Service["mysql"],
    force  => true
  }

}

include lamp
