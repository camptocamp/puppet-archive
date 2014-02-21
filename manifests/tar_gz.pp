define archive::tar_gz($source, $target) {

  Exec { path => [ "/usr/bin:/bin:/usr/sbin:/sbin" ] }

  exec {"$name unpack":
    command => "curl ${source} | tar -xzf - -C ${target} && touch ${name}",
    creates => $name,
    require => Package[curl],
  }
}
