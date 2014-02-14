/*

== Definition: archive::extract

Archive extractor.

Parameters:

- *$target: Destination directory
- *$src_target: Default value "/usr/src".
- *$root_dir: Default value "".
- *$extension: Default value ".tar.gz".
- *$timeout: Default value 120.

Example usage:

  archive::extract {"apache-tomcat-6.0.26":
    ensure => present,
    target => "/opt",
  }

This means we want to extract the local archive
(maybe downloaded with archive::download)
'/usr/src/apache-tomcat-6.0.26.tar.gz' in '/src/apache-tomcat-6.0.26'

Warning:

The parameter *$root_dir* must be used if the root directory of the archive
is different from the name of the archive *$name*. To extract the name of
the root directory use the commands "tar tf archive.tar.gz" or
"unzip -l archive.zip"

*/
define archive::extract (
  $target,
  $ensure=present,
  $src_target='/usr/src',
  $root_dir='',
  $extension='tar.gz',
  $timeout=120) {

  if $root_dir != '' {
    $extract_dir = "${target}/${root_dir}"
  } else {
    $extract_dir = "${target}/${name}"
  }

  case $ensure {
    present: {

      file {$target:
        ensure => directory,
      }

      $extract_zip    = "unzip -o ${src_target}/${name}.${extension} -d ${target}"
      $extract_tar    = "tar --no-same-owner --no-same-permissions -xf ${src_target}/${name}.${extension} -C ${target}"
      $extract_targz  = "tar --no-same-owner --no-same-permissions -xzf ${src_target}/${name}.${extension} -C ${target}"
      $extract_tarbz2 = "tar --no-same-owner --no-same-permissions -xjf ${src_target}/${name}.${extension} -C ${target}"
      $extract_rpm    = "rpm2cpio ${src_target}/${name}.${extension} | cpio --no-preserve-owner -id"

      exec {"$name unpack":
        command => $extension ? {
          'zip'     => "mkdir -p ${target} && ${extract_zip}",
          'tar'     => "mkdir -p ${target} && ${extract_tar}",
          'tar.gz'  => "mkdir -p ${target} && ${extract_targz}",
          'tgz'     => "mkdir -p ${target} && ${extract_targz}",
          'tar.bz2' => "mkdir -p ${target} && ${extract_tarbz2}",
          'tgz2'    => "mkdir -p ${target} && ${extract_tarbz2}",
          'rpm'     => "mkdir -p ${target} && ${extract_rpm}",
          default   => fail ( "Unknown extension value '${extension}'" ),
        },
        path    => ['/bin', '/usr/bin'],
        creates => $extract_dir,
        timeout => $timeout,
        cwd     => $target,
        require => File[$target],
      }
    }
    absent: {
      file {$extract_dir:
        ensure  => absent,
        recurse => true,
        purge   => true,
        force   => true,
      }
    }
    default: { err ( "Unknown ensure value: '${ensure}'" ) }
  }
}
