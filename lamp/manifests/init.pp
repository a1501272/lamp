class lamp {
	 package { "apache2":}
	 package { "libapache2-mod-php":}
	 package { "php":}
	 package { "mysql-server":}
	 package { "mysql-client":}


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
}




















