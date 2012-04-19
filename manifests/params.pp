class autofs::params {

  case $osfamily {
    "Debian": {
      $concat_gnu = true
      $group      = 'root'
      $master     = '/etc/auto.master'
      $owner      = 'root'
      $package    = [ 'autofs', 'autofs-ldap' ]
      $service    = 'autofs'
    }
    "Solaris": {
      $concat_gnu = false
      $group      = 'root'
      $master     = '/etc/auto_master'
      $owner      = 'root'
      $package    = [] # solaris has it built-in, no package required
      $service    = 'autofs'
    }
    default: {
      fail("osfamily not supported: $osfamily")
    }
  }

}
