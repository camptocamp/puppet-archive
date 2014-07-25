define archive::zip($source, $target) {
  exec {"$name unpack":
    command => "TMPFILE=\$(mktemp); curl -s -S -o \${TMPFILE}.zip ${source} && unzip \${TMPFILE}.zip -d ${target} && rm \$TMPFILE && rm \${TMPFILE}.zip && touch ${name}",
    path    => '/usr/bin',
    creates => $name,
    require => Package['unzip'],
  }
}
