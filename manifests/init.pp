# Configure taps and automatic upgrades
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
  exec { 'brew upgrade':
    timeout => 0,
    onlyif  => 'brew update | grep Updated'
  } ~>
  exec { 'cask_upgrade':
    command     => "sudo -u ${::user} cask_upgrade",
    timeout     => 0,
    refreshonly => true,
    require     => Class['::dotfiles']
  }
}
