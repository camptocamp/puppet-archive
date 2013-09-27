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
