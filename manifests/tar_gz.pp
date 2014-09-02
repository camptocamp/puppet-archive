# See README.md for details.
define archive::tar_gz($source, $target) {
  exec {"${name} unpack":
    command => "curl -s -S ${source} | tar -xzf - -C ${target} && touch ${name}",
    creates => $name,
    require => Package[curl],
  }
}
