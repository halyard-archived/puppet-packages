class packages {
  require homebrew
  require brewcask
  require sudoers

  sudoers::allowed_command { 'brewcask-pkginstaller':
    command          => '/usr/sbin/installer',
    user             => $::boxen_user,
    require_password => false,
    comment          => 'Allow brewcask to use sudo for installer',
    tags             => ['SETENV'],
    require_exist    => false
  } ->
  homebrew::tap {
    [
      'homebrew/dupes',
      'halyard/formulae',
      'halyard/casks'
    ]:
  } ->
  exec { 'brew upgrade --all':
    timeout => 0
  }
}
