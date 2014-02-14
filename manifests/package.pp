# == Definition: archive::package
#
# This definition provides the dependencies for extracting the given archive.
#
# === Parameters
#
# [*ensure*]
#   Makes sure, the package dependencies are only enforced when the existence of
#   the archive file to be extracted is ensured.
#
# [*extension*]
#   The extension of the archive to be extracted - used to determine the package
#   dependencies (e.g. 'tar.gz': 'tar', 'rpm': 'rpm2cpio, cpio', ...
#
# === Examples
#
# Install the package requirements for extracting an 'rpm' file
#
# archive::package { 'some-file':
#   extension => 'rpm',
# }
#
# === Authors
#
# Elias Probst <mail@eliasprobst.eu>
#
# === Copyright
#
# Copyright 2013, Elias Probst
#

define archive::package (
    $ensure    = present,
    $extension = 'tar.gz'
) {
    case $ensure {
        present: {
            case $extension {
                'zip':     { $packages = [ 'unzip' ] }
                'tar':     { $packages = [ 'tar' ] }
                'tar.gz':  { $packages = [ 'tar' ] }
                'tgz':     { $packages = [ 'tar' ] }
                'tar.bz2': { $packages = [ 'tar' ] }
                'tgz2':    { $packages = [ 'tar' ] }
                'rpm':     { $packages = [ 'rpm2cpio', 'cpio' ] }
                default:   { fail ( "Unknown extension value '${extension}'" ) }
            }

            package {$packages:
                ensure => present,
            }
        }
        absent: {}
        default: { err( "Unknown value for ensure: ${ensure}" ) }
    }
}
