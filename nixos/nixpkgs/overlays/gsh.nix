self: super: {
  gsh = import
    (fetchGit {
      url = "git@github.com:Genially/gsh";
      ref = "refs/heads/main";
      rev = "994b65064f7858e56d192089dc6481021f178bbe";
    })
    { };
}
