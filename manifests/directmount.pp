define autofs::directmount (
  $location,
  $ensure     = 'present',
  $mountpoint = $title,
  $options    = undef,
  $mapfile    = undef
) {
  include autofs
  include autofs::params

  if $mapfile != undef {
    validate_absolute_path($mapfile)
    $path = $mapfile
  } else {
    $path = $autofs::params::master
  }

  autofs::mapfile { "autofs::mount ${title}":
    path => $path
  }

  concat { $path:
    ensure  => $ensure,
    owner  => $autofs::params::owner,
    group  => $autofs::params::group,
    mode  => '0644'
  }

  concat::fragment { "autofs::mount ${path}:${mountpoint}":
    target  => $path,
    content => "${mountpoint} ${options} ${location}\n",
    order   => '100',
  }

}
