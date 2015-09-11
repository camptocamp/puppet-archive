# See README.md for details.
define archive::tar_gz($source, $target, $path=$::path) {

  include ::archive::params
  Class['archive::params'] ->
  Archive::Tar_gz[$name]

  exec {"${name} unpack":
    command => "curl -s -S ${source} | ${::archive::params::tarcmd} -xzf - -C ${target} && touch ${name}",
    creates => $name,
    path    => $path,
    require => Package[curl],
  }
}
