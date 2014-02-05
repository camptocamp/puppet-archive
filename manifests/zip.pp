define archive::zip($source, $target) {
  exec {"$name unpack":
    path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin' ],
    command => "TMPFILE=\$(mktemp); curl -o \${TMPFILE}.zip ${source} && unzip \${TMPFILE}.zip -d ${target} && rm \$TMPFILE && rm \${TMPFILE}.zip && touch ${name}",
    creates => $name,
    require => Package['unzip'],
  }
}
