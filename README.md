Archive Puppet Module
====================

[![Puppet Forge Version](http://img.shields.io/puppetforge/v/camptocamp/archive.svg)](https://forge.puppetlabs.com/camptocamp/archive)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/camptocamp/archive.svg)](https://forge.puppetlabs.com/camptocamp/archive)
[![Build Status](https://img.shields.io/travis/camptocamp/puppet-archive/master.svg)](https://travis-ci.org/camptocamp/puppet-archive)
[![Gemnasium](https://img.shields.io/gemnasium/camptocamp/puppet-archive.svg)](https://gemnasium.com/camptocamp/puppet-archive)
[![By Camptocamp](https://img.shields.io/badge/by-camptocamp-fb7047.svg)](http://www.camptocamp.com)

Overview
--------

Puppet Module to download and extract tar and zip archives based on [camptocamp/puppet-archive](https://github.com/camptocamp/puppet-archive).

Supported archive types are:

- `tar.gz`, `tgz`
- `tar.bz2`, `tbz2`
- `tar.xz`, `txz`
- `zip`

Features:

- Ability to follow redirects
- Supports checksum matching

Usage
-----

Example:

    archive { 'apache-tomcat-6.0.26':
"../README.md" 112L, 3378C                                                                                                                                           1,1           Top

    archive { 'apache-tomcat-6.0.26':
      ensure => present,
      url    => 'http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz',
      target => '/opt',
    }

You can have archive follow redirects by setting:

```
follow_redirects => true
````

The default archive format is ```tar.gz```. To use another supported format you must specify the extenstion:

```
extension => "zip"
```

By default archive will try and find a matching checksum file to verify the download. To disable this behavior set the ```checksum``` option to ```false```:

```
checksum => false
```

You can specify a ```digest_url```, ```digest_string``` and ```digest_type``` to verify archive integrity.

For `.tar.gz` and `tar.bz2` archives, the extract step's `--strip-components=n` flag can be accessed. This can be used to [change the name of the extracted directory](http://unix.stackexchange.com/questions/11018/how-to-choose-directory-name-during-untarring).

```
strip_components => 1
                                                                                                                                                                     49,0-1        37%
strip_components => 1
```

```
purge_target => false
```

By default the target directory is left intact, this option can be used to `rm -rf` the target directory prior to extraction.

This full example will download the [packer](packer.io) tool to ```/usr/local/bin```:

```
archive { '0.5.1_linux_amd64':
   ensure => present,
   url => 'https://dl.bintray.com/mitchellh/packer/0.5.1_linux_amd64.zip',
   target => '/usr/local/bin',
   follow_redirects => true,
   extension => 'zip',
   checksum => false,
   src_target => '/tmp'
}
```

You can also specifiy a global user to be used for the whole download and extract operation. Note that the module doesn't handle the right of the specified user on the src_target directory.
```

archive { '0.5.1_linux_amd64':
   ensure => present,
   url => 'https://dl.bintray.com/mitchellh/packer/0.5.1_linux_amd64.zip',
   target => '/usr/local/bin',
   follow_redirects => true,
search hit BOTTOM, continuing at TOP
Overview
--------

Puppet Module to download and extract tar and zip archives based on [camptocamp/puppet-archive](https://github.com/camptocamp/puppet-archive).

Supported archive types are:

- `tar.gz`, `tgz`
- `tar.bz2`, `tbz2`
- `tar.xz`, `txz`
- `zip`

Features:

- Ability to follow redirects
- Supports checksum matching

Usage
-----

Example:

    archive { 'apache-tomcat-6.0.26':
      ensure => present,
      url    => 'http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz',
      target => '/opt',
    }

You can have archive follow redirects by setting:

```
follow_redirects => true
/follow

```
purge_target => false
```

By default the target directory is left intact, this option can be used to `rm -rf` the target directory prior to extraction.

This full example will download the [packer](packer.io) tool to ```/usr/local/bin```:

```
archive { '0.5.1_linux_amd64':
   ensure => present,
   url => 'https://dl.bintray.com/mitchellh/packer/0.5.1_linux_amd64.zip',
   target => '/usr/local/bin',
   follow_redirects => true,
   extension => 'zip',
   checksum => false,
   src_target => '/tmp'
}
```

You can also specifiy a global user to be used for the whole download and extract operation. Note that the module doesn't handle the right of the specified user on the src_target directory.
```

archive { '0.5.1_linux_amd64':
   ensure => present,
   url => 'https://dl.bintray.com/mitchellh/packer/0.5.1_linux_amd64.zip',
   target => '/usr/local/bin',
   follow_redirects => true,
   extension => 'zip',
   checksum => false,
search hit BOTTOM, continuing at TOP
    true    => '-k',
    default => '',
  }

  $redirect_arg = $follow_redirects ? {
    true    => '-L',
    default => '',
  }

  $cookie_arg = $allow_cookie ? {
        true => "-H \"Cookie: $cookie_value\"",
        default => '',
  }

  if !defined(Package['curl']) {
    package{'curl':
      ensure => present,
    }
  }

  if $proxy_server {
    $proxy_option = "--proxy ${proxy_server}"
  } else {
    $proxy_option = undef
  }

vagrant@vagrantvlc:/etc/puppet/modules/archive/manifests$ ls
download.pp  extract.pp  init.pp  tar_gz.pp  zip.pp
vagrant@vagrantvlc:/etc/puppet/modules/archive/manifests$ vi tar_gz.pp
vagrant@vagrantvlc:/etc/puppet/modules/archive/manifests$ less ../README.md
vagrant@vagrantvlc:/etc/puppet/modules/archive/manifests$ vi ../README.md
vagrant@vagrantvlc:/etc/puppet/modules/archive/manifests$ sudo vi ../README.md
vagrant@vagrantvlc:/etc/puppet/modules/archive/manifests$ cat ../README.md
Archive Puppet Module
====================

[![Puppet Forge Version](http://img.shields.io/puppetforge/v/camptocamp/archive.svg)](https://forge.puppetlabs.com/camptocamp/archive)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/camptocamp/archive.svg)](https://forge.puppetlabs.com/camptocamp/archive)
[![Build Status](https://img.shields.io/travis/camptocamp/puppet-archive/master.svg)](https://travis-ci.org/camptocamp/puppet-archive)
[![Gemnasium](https://img.shields.io/gemnasium/camptocamp/puppet-archive.svg)](https://gemnasium.com/camptocamp/puppet-archive)
[![By Camptocamp](https://img.shields.io/badge/by-camptocamp-fb7047.svg)](http://www.camptocamp.com)

Overview
--------

Puppet Module to download and extract tar and zip archives based on [camptocamp/puppet-archive](https://github.com/camptocamp/puppet-archive).

Supported archive types are:

- `tar.gz`, `tgz`
- `tar.bz2`, `tbz2`
- `tar.xz`, `txz`
- `zip`

Features:

- Ability to follow redirects
- Supports checksum matching

Usage
-----

Example:

    archive { 'apache-tomcat-6.0.26':
      ensure => present,
      url    => 'http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz',
      target => '/opt',
    }

You can have archive follow redirects by setting:

```
follow_redirects => true
````

You can set and use prepared cookies using the settings:

```
allow_cookie => true
cookie_value => 'some-licence=accept-cookie'
````

The default archive format is ```tar.gz```. To use another supported format you must specify the extenstion:

```
extension => "zip"
```

By default archive will try and find a matching checksum file to verify the download. To disable this behavior set the ```checksum``` option to ```false```:

```
checksum => false
```

You can specify a ```digest_url```, ```digest_string``` and ```digest_type``` to verify archive integrity.

For `.tar.gz` and `tar.bz2` archives, the extract step's `--strip-components=n` flag can be accessed. This can be used to [change the name of the extracted directory](http://unix.stackexchange.com/questions/11018/how-to-choose-directory-name-during-untarring).

```
strip_components => 1
```

```
purge_target => false
```

By default the target directory is left intact, this option can be used to `rm -rf` the target directory prior to extraction.

This full example will download the [packer](packer.io) tool to ```/usr/local/bin```:

```
archive { '0.5.1_linux_amd64':
   ensure => present,
   url => 'https://dl.bintray.com/mitchellh/packer/0.5.1_linux_amd64.zip',
   target => '/usr/local/bin',
   follow_redirects => true,
   extension => 'zip',
   checksum => false,
   src_target => '/tmp'
}
```

You can also specifiy a global user to be used for the whole download and extract operation. Note that the module doesn't handle the right of the specified user on the src_target directory.
```

archive { '0.5.1_linux_amd64':
   ensure => present,
   url => 'https://dl.bintray.com/mitchellh/packer/0.5.1_linux_amd64.zip',
   target => '/usr/local/bin',
   follow_redirects => true,
   extension => 'zip',
   checksum => false,
   user       => 'camptocamp',
   src_target => '/home/camptocamp'
}
```

To download oracle java with the approved cookie, you can use the following:
```

archive { 'jdk-8u91-linux-x64':
	url => 'http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz',
	target => '/usr/java',
	digest_string => '3f3d7d0cd70bfe0feab382ed4b0e45c0',
	digest_type => 'md5',
	cookie_value=>'oraclelicense=accept-securebackup-cookie',
	allow_cookie=>true,
	follow_redirects => true,
}

```

License
-------

Copyright (c) 2012 Camptocamp SA

This script is licensed under the Apache License, Version 2.0.

See http://www.apache.org/licenses/LICENSE-2.0.html for the full license text.


Support
-------

Please log tickets and issues at our [project site](https://github.com/camptocamp/puppet-archive/issues).
