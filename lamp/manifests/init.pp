class lamp {
	 package { "apache2":}
	 package { "libapache2-mod-php":}
	 package { "php":}
	 package { "mysql-server":}
	 package { "mysql-client":}
	 package { "php-mysql":}

	 file { "/home/alex/public_html/index.php":
		 content => template ("lamp/index.php"),

	 }	


	 file { "/etc/apache2/mods-enabled/userdir.conf":
		 ensure => "link",
		 target => "../mods-available/userdir.conf",
		 notify => Service ["apache2"],

	 }

	 file { "/etc/apache2/mods-enabled/userdir.load":
		 ensure => "link",
		 target => "../mods-available/userdir.load",
		 notify => Service ["apache2"],

	 }

	 file { "/etc/apache2/mods-available/php7.0.conf":
		 content => template ("lamp/php7.0.conf"),
		 notify => Service ["apache2"],

	 }
	file { "/var/www/html/index.php":
		 content => template ("lamp/index.php"),
		 ensure => "directory",

	 }
	
	file { "/etc/skel/public_html":
		 ensure => "directory",

	 }

	 file { "/etc/skel/public_html/index.php":
		 content => template ("lamp/index.php"),

	 }

	 service { "apache2":
		 ensure => "running",
		 enable => "true",
		 provider => "systemd",
		 require => Package["apache2"],

	 }
	 service { "mysql":
		 ensure => "running",
		 enable => "true",
		 provider => "systemd",
		 require => Package["mysql-server"],

	 }
#tämä tuottaa virheen		
	exec { 'mysql-db':
		command => "mysql -uroot -e \"create database puppet; grant all on puppet.* to puppet@localhost identified by 'Pa33w0rd12345';\"",
		unless => 'mysqlshow puppet',
		path => '/bin/:/usr/bin/:/sbin/:/usr/sbin/',
		require => Service["mysql"],
	}

}




















