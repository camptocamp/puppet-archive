# == Definition: archive::download
#
# Archive downloader with integrity verification.
#
# Parameters:
#
# - *$url:
# - *$digest_url:
# - *$digest_string: Default value undef
# - *$digest_type: Default value "md5".
# - *$timeout: Default value 120.
# - *$src_target: Default value "/usr/src".
# - *$allow_insecure: Default value false.
# - *$follow_redirects: Default value false.
# - *$verbose: Default value true.
# - *$proxy_server: Default value undef.
# - *$user: The user used to download the archive
#
# Example usage:
#
#  archive::download {"apache-tomcat-6.0.26.tar.gz":
#    ensure => present,
#    url    => "http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz",
#  }
#
#  archive::download {"apache-tomcat-6.0.26.tar.gz":
#    ensure        => present,
#    digest_string => "f9eafa9bfd620324d1270ae8f09a8c89",
#    url           => "http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz",
#  }
#

# JOE
if $::osfamily == 'Windows' { 
  $default_src_target = 'c:\\Temp'
  $exec_provider = 'cygwin'
} else { 
  $default_src_target = '/usr/src'
  $exec_provider = 'posix'
}

define archive::download (
  $url,
  $ensure=present,
  $checksum=true,
  $digest_url=undef,
  $digest_string=undef,
  $digest_type='md5',
  $timeout=120,
  $src_target=$default_src_target,
  $allow_insecure=false,
  $follow_redirects=false,
  $verbose=true,
  $path=$::path,
  $proxy_server=undef,
  $user=undef,
) {

	# JOE
	if $::osfamily == 'Windows' { 
	  $default_src_target = 'c:\\Temp'
	  $exec_provider      = 'cygwin'
	  $package_curl       = Exec['cygwin_package_curl']
	} else { 
	  $default_src_target = '/usr/src'
	  $exec_provider      = 'posix'
	  $package_curl       = Package['curl']
	}

  $insecure_arg = $allow_insecure ? {
    true    => '-k',
    default => '',
  }

  $redirect_arg = $follow_redirects ? {
    true    => '-L',
    default => '',
  }

  if !defined($package_curl) {
    package{'curl':
      ensure => present,
    }
  }

  if $proxy_server {
    $proxy_option = "--proxy ${proxy_server}"
  } else {
    $proxy_option = undef
  }

  case $checksum {
    true : {
      case $digest_type {
        'md5','sha1','sha224','sha256','sha384','sha512' : {
          $checksum_cmd = "${digest_type}sum -c ${name}.${digest_type}"
        }
        default: { fail 'Unimplemented digest type' }
      }

      if $digest_url and $digest_string {
        fail 'digest_url and digest_string should not be used together !'
      }

      if $digest_string {
        case $ensure {
          'present': {
            file {"${src_target}/${name}.${digest_type}":
              ensure  => $ensure,
              content => "${digest_string} *${name}",
              owner   => $user,
              notify  => Exec["download archive ${name} and check sum"],
            }
          }
          'absent': {
            file {"${src_target}/${name}.${digest_type}":
              ensure => absent,
              purge  => true,
              owner  => $user,
              force  => true,
            }
          }
          default: {
            fail('$ensure can only be present or absent.')
          }
        }
      } else {
        case $ensure {
          'present': {

            if !$digest_url {
              $digest_src = "${url}.${digest_type}"
            } else {
              $digest_src = $digest_url
            }


            exec {"download digest of archive ${name}":
              command => "curl ${proxy_option} -s -S ${insecure_arg} ${redirect_arg} -o ${src_target}/${name}.${digest_type} '${digest_src}'",
              creates => "${src_target}/${name}.${digest_type}",
              timeout => $timeout,
              path    => $path,
              notify  => Exec["download archive ${name} and check sum"],
              user    => $user,
              require => $package_curl,
				  provider    => $exec_provider,
            }

          }
          'absent': {
            file{"${src_target}/${name}.${digest_type}":
              ensure => absent,
              purge  => true,
              owner  => $user,
              force  => true,
            }
          }
          default: {
            fail('$ensure can only be present or absent.')
          }
        }
      }
    }
    false :  {
      $checksum_cmd = undef # Fix for strict_variables
      if $verbose {
        notice 'No checksum for this archive'
      }
    }
    default: { fail ( "Unknown checksum value: '${checksum}'" ) }
  }

  case $ensure {
    'present': {
      $_notify     = $checksum ? {
        true    => Exec["rm-on-error-${name}"],
        default => undef,
      }
      $refreshonly = $checksum ? {
        true    => true,
        default => undef,
      }
      if $::osfamily == 'Windows' {
	      # TODO: Implement Package['curl'] for Windows.
	      exec {"download archive ${name} and check sum":
	        command     => "/usr/bin/curl -s -S ${insecure_arg} ${redirect_arg} -o ${src_target}/${name} '${url}'",
	        creates     => "${src_target}/${name}",
	        logoutput   => true,
	        timeout     => $timeout,
			  require     => $package_curl,
	        notify      => $_notify,
	        refreshonly => $refreshonly,
	        provider    => $exec_provider,
	      }
      } else {
	      exec {"download archive ${name} and check sum":
           command     => "curl ${proxy_option} -s -S ${insecure_arg} ${redirect_arg} -o ${src_target}/${name} '${url}'",
           creates     => "${src_target}/${name}",
           logoutput   => true,
           timeout     => $timeout,
           path        => $path,
			  require     => $package_curl,
           notify      => $_notify,
           user        => $user,
           refreshonly => $refreshonly,
	        provider    => $exec_provider,
	      }
      }

			exec {"rm-on-error-${name}":
        command     => "rm -f ${src_target}/${name} ${src_target}/${name}.${digest_type} && exit 1",
        unless      => $checksum_cmd,
        cwd         => $src_target,
        path        => $path,
        refreshonly => true,
	     provider    => $exec_provider,
      }
    }
    'absent': {
      file {"${src_target}/${name}":
        ensure => absent,
        purge  => true,
        force  => true,
      }
    }
    default: { fail ( "Unknown ensure value: '${ensure}'" ) }
  }
}
