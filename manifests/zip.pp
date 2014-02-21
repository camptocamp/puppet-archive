define archive::zip($source, $target) {

  Exec { path => [ "/usr/bin:/bin:/usr/sbin:/sbin" ] }

  exec {"$name unpack":
    command => "TMPFILE=\$(mktemp); curl -o \${TMPFILE}.zip ${source} && unzip \${TMPFILE}.zip -d ${target} && rm \$TMPFILE && rm \${TMPFILE}.zip && touch ${name}",
    creates => $name,
    require => Package['unzip'],
  }
}
