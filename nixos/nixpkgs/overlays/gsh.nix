self: super: {
  gsh = import
    (fetchGit {
      url = "git@github.com:Genially/gsh";
      ref = "refs/heads/main";
      rev = "25bf31d3e3a2a0baf3797f7b182b3c3e6bd4d29a";
    })
    { };
}
