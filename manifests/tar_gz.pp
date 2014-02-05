define archive::tar_gz($source, $target) {
  exec {"$name unpack":
    path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin' ],
    command => "curl ${source} | tar -xzf - -C ${target} && touch ${name}",
    creates => $name,
    require => Package[curl],
  }
}
