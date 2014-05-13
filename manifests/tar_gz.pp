define archive::tar_gz($source, $target) {
  exec {"$name unpack":
    command => "curl -s -S ${source} | tar -xzf - -C ${target} && touch ${name}",
    path    => '/usr/bin',
    creates => $name,
    require => Package[curl],
  }
}
