# Internal class

class jenkins::install {

  java::oracle { 'jdk8' :
    ensure  => 'present',
    version => '8',
    java_se => 'jdk',
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
