# Define: archive::zip
# Parameters:
# - source (where to download file to)
# - target (where to unpack file to)
#
#
define archive::zip($source, $target) {
  exec {"${name} unpack":
    command => "TMPFILE=\$(mktemp); curl -o \${TMPFILE}.zip ${source} && unzip \${TMPFILE}.zip -d ${target} && rm \$TMPFILE && rm \${TMPFILE}.zip && touch ${name}",
    creates => $name,
    require => Package['unzip'],
  }
}
