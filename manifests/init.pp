class packages {
  require homebrew
  require brewcask

  Package {
    provider => homebrew,
    require  => Class['homebrew'],
    install_options => ['--build-from-source']
  }

  homebrew::tap {
    [
      'homebrew/dupes',
      'halyard/formulae',
      'halyard/casks'
    ]:
  }

  exec { 'update formulas':
    command => 'brew update'
  }

  package {
    [
      'ack',
      'arping',
      'bash',
      'bash-completion',
      'coreutils',
      'cpanminus',
      'ctags',
      'findutils',
      'gawk',
      'git',
      'gnupg',
      'gnupg2',
      'gnuplot',
      'gnutls',
      'gnu-tar',
      'go',
      'gpg-agent',
      'gpgme',
      'htop-osx',
      'hub',
      'ipmitool',
      'mutt',
      'mysql',
      'netcat',
      'nmap',
      'node',
      'openssl',
      'pinentry',
      'pwgen',
      'python',
      'python3',
      'qrencode',
      'readline',
      'redis',
      'siege',
      'socat',
      'sqlite',
      'swig',
      'tmux',
      'tree',
      'vim',
      'watch',
      'weechat',
      'wget',
      'xz',
      'yuicompressor',
      'zsh',
      'zsh-completions'
    ]:
    require => Exec['update formulas']
  }

  package { 'mtr':
    install_options => [
      '--build-from-source',
      '--no-gtk+'
    ],
    require => Exec['update formulas']
  }

  file { 'mtr-binary':
    path    => "${boxen::config::home}/homebrew/sbin/mtr",
    links   => 'follow',
    owner   => 'root',
    group   => 'wheel',
    mode    => '4755',
    require => Package['mtr']
  }

  package {
    [
      'encfs-halyard',
      'openssh-halyard',
      'ipmiutil-halyard'
    ]:
    require => [
      Homebrew::Tap['halyard/formulae'],
      Package['osxfuse-halyard'],
      Exec['update formulas']
    ]
  }

  package {
    [
      'homebrew/dupes/apple-gcc42',
      'homebrew/dupes/grep',
      'homebrew/dupes/screen'
    ]:
    require => [
      Homebrew::Tap['homebrew/dupes'],
      Exec['update formulas']
    ]
  }

  package {
    [
      'airmail-beta-halyard',
      'alfred-halyard',
      'asepsis-halyard',
      'bartender-halyard',
      'bettertouchtool-halyard',
      'cert-quicklook-halyard',
      'copy-halyard',
      'dropbox-halyard',
      'firefox-beta-halyard',
      'flux-halyard',
      'font-meslo-lg-for-powerline-halyard',
      'google-chrome-dev-halyard',
      'google-drive-halyard',
      'gpgtools-halyard',
      'grandperspective-halyard',
      'hyperspace-halyard',
      'jre-halyard',
      'istat-menus-halyard',
      'iterm2-nightly-halyard',
      'lingon-x-halyard',
      'little-snitch-nightly-halyard',
      'luxdelux-halyard',
      'navicat-for-mysql-halyard',
      'onepassword-beta-halyard',
      'openoffice-halyard',
      'osxfuse-halyard',
      'quicklook-json-halyard',
      'rstudio-halyard',
      'sequelpro-halyard',
      'textexpander-halyard',
      'the-unarchiver-halyard',
      'thunderbird-beta-halyard',
      'totalfinder-halyard',
      'totalspaces-halyard',
      'transmission-halyard',
      'vagrant-halyard',
      'virtualbox-ext-pack-halyard',
      'virtualbox-halyard',
      'vlc-halyard',
      'xee-halyard'
    ]:
    provider    => 'brewcask',
    require     => [
      Sudoers['brewcask-pkginstaller'],
      Homebrew::Tap['halyard/casks'],
      Exec['update formulas']
    ]
  }

  sudoers { 'brewcask-pkginstaller':
    users       => $::boxen_user,
    hosts       => 'ALL',
    commands    => [
      '(ALL) NOPASSWD:SETENV: /usr/sbin/installer',
    ],
    type        => 'user_spec',
  }
}
