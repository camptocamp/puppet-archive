# Define: archive::tar_gz
# Parameters:
# - source (where to download file to)
# - target (where to unpack file to)
#
define archive::tar_gz($source, $target) {
  exec {"${name} unpack":
    command => "curl ${source} | tar -xzf - -C ${target} && touch ${name}",
    creates => $name,
    require => Package[curl],
  }
}
