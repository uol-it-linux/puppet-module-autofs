define autofs::mount (
  $map,
  $ensure     = present,
  $mountpoint = $title,
  $options    = undef,
  $mapfile    = undef
) {
  include autofs
  include autofs::params

  if $mapfile != undef {
    validate_absolute_path($mapfile)
    $path = $mapfile
    $content = "${mountpoint} ${options} ${map}\n"
  } else {
    $path = $autofs::params::master
    $content = "${mountpoint} ${map} ${options}\n"
  }

  autofs::mapfile { "autofs::mount ${title}":
    path => $path
  }

  concat::fragment { "autofs::mount ${path}:${mountpoint}":
    ensure  => $ensure,
    target  => $path,
    content => $content,
    order   => '100',
  }

}
