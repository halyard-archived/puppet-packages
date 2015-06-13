class packages {
  require homebrew
  require brewcask

  sudoers::allowed_commands { 'brewcask-pkginstaller':
    command          => '/usr/sbin/installer',
    user             => $::boxen_user,
    require_password => false,
    comment          => 'Allow brewcask to use sudo for installer'
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
