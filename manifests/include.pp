# == Define: autofs::include

define autofs::include (
  $map     = $title,
  $mapfile = undef,
  $order   = '200',
) {
  include autofs
  include autofs::params

  if $mapfile != undef {
    validate_absolute_path($mapfile)
    $mapfile_real = $mapfile
  } else {
    $mapfile_real = $autofs::params::master
  }

  autofs::mapfile::line { "autofs::include ${title}":
    mapfile => $mapfile_real,
    content => "+${map}\n",
    order   => $order,
  }

}
