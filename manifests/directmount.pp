#== Define: autofs::directmount

define autofs::directmount (
  $location,
  $ensure     = 'present',
  $mountpoint = $title,
  $options    = undef,
  $mapfile    = undef,
  $order      = undef,
) {
  include autofs
  include autofs::params

  if $mapfile != undef {
    validate_absolute_path($mapfile)
    $mapfile_real = $mapfile
  } else {
    $mapfile_real = $autofs::params::master
  }

  autofs::mapfile::line { "autofs::mount ${mapfile_real}:${mountpoint}":
    mapfile => $mapfile_real,
    content => "${mountpoint} ${options} ${location}\n",
    order   => $order,
  }

}
