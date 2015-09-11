# Private class, do not use directly
# steers some defaults of the defined archive types

class archive::params {

  case $::osfamily {
    'OpenBSD': {
      $tarcmd = 'gtar'
      $digest_types = {
        'md5' => 'md5',
        'sha1' => 'sha1',
        'sha256' => 'sha256',
        'sha512' => 'sha512',
      }
    }
    default: {
      $tarcmd = 'tar'
      $digest_types = {
        'md5' => 'md5sum',
        'sha1' => 'sha1sum',
        'sha224' => 'sha224sum',
        'sha256' => 'sha256sum',
        'sha384' => 'sha384sum',
        'sha512' => 'sha512sum',
      }
    }
  }
}
