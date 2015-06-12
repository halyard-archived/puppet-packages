class packages {
  require homebrew
  require brewcask

  homebrew::tap {
    [
      'homebrew/dupes',
      'halyard/formulae',
      'halyard/casks'
    ]:
  }
}
