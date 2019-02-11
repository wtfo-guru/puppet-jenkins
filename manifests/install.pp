class jenkins::install {

  class { 'java':
    distribution => 'jre',
    version => '8u201',
  }

  case $facts['os']['family'] {
    'Debian': {
      apt::source { 'jenkins-stable':
        comment  => 'debian stable repo',
        location => 'https://pkg.jenkins.io/debian-stable',
        release  => 'binary/',
        repos    => '',
        key      => {
          'id'     => '150FDE3F7787E7D11EF4E12A9B7D32F2D50582E6',
          'source' => 'http://pkg.jenkins.io/debian-stable/jenkins.io.key',
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

  package { 'jenkins':
    ensure => installed,
  }

}
