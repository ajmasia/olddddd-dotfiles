self: super: {
  gsh = import
    (fetchGit {
      url = "git@github.com:Genially/gsh";
      ref = "refs/heads/main";
      rev = "0f0da5deb26c2f6764430886466b91658bb3454e";
    })
    { };
}
