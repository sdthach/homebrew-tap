# homebrew-tap

Homebrew tap for my fork of [git-toolbelt](https://github.com/sdthach/git-toolbelt).

```console
$ brew install sdthach/tap/git-toolbelt          # stable (pinned release)
$ brew install --HEAD sdthach/tap/git-toolbelt   # tip of main
```

git-toolbelt is also installable with [mise](https://mise.jdx.dev), from the same release tarball this formula points at — one artifact, one checksum, so the two paths cannot drift:

```console
$ mise use -g github:sdthach/git-toolbelt
```

## Do not edit the formula here

[`git-toolbelt.rb`](git-toolbelt.rb) is **generated**. On each release, `release.yml` in the main repo copies `packaging/git-toolbelt.rb` over this file wholesale and rewrites only `url` and `sha256`. Edits made here are silently overwritten by the next release — change `packaging/git-toolbelt.rb` in [sdthach/git-toolbelt](https://github.com/sdthach/git-toolbelt) instead.

See [maintaining-the-fork](https://github.com/sdthach/git-toolbelt/blob/main/docs/maintaining-the-fork.md) for how the two repos fit together.
