class packages {
  require homebrew
  require brewcask

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
