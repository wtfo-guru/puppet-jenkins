class jenkins::install {

  class { 'java':
    distribution => 'jre',
  }

  case $facts['os']['family'] {
    'Debian': {
      apt::source { 'jenkins-stable':
        comment  => 'debian stable repo',
        location => 'https://pkg.jenkins.io/debian-stable',
        release  => 'stable',
        repos    => 'binary/',
        key      => {
          'source'     => 'http://pkg.jenkins.io/debian-stable/jenkins.io.key',
        },
        include  => {
          'src' => false,
          'deb' => true,
        },
      }
    }
    default: {
      yumrepo { 'jenkins':
        ensure   => 'present',
        baseurl  => 'http://pkg.jenkins.io/redhat',
        descr    => 'Jenkins',
        gpgkey   => 'https://pkg.jenkins.io/redhat/jenkins.io.key',
        gpgcheck => '1',
      }
    }
  }

  yumrepo { 'jenkins':
    ensure   => 'present',
    baseurl  => 'http://pkg.jenkins.io/redhat',
    descr    => 'Jenkins',
    gpgkey   => 'https://pkg.jenkins.io/redhat/jenkins.io.key',
    gpgcheck => '1',
  }

  package { 'jenkins':
    ensure => installed,
  }

}
