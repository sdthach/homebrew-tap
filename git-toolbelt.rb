# Homebrew formula for the git-toolbelt fork (github.com/sdthach/git-toolbelt).
#
# This is the TAP copy that `brew` actually reads. The source of truth lives in
# packaging/git-toolbelt.rb in sdthach/git-toolbelt; the url+sha256 below are
# kept in sync automatically by that repo's .github/workflows/release.yml on
# each pushed v* tag (see docs/maintaining-the-fork.md).
#
# INSTALL
#   Stable (pinned tag):   brew install sdthach/tap/git-toolbelt
#   HEAD (tip of main):    brew install --HEAD sdthach/tap/git-toolbelt
class GitToolbelt < Formula
  desc "Helper commands and g+verb shortcuts to make everyday life with Git easier"
  homepage "https://github.com/sdthach/git-toolbelt"
  license "BSD-3-Clause"

  url "https://github.com/sdthach/git-toolbelt/archive/refs/tags/v1.12.0-fork.1.tar.gz"
  sha256 "bb02fdb972004cd80e931d25e5efd06e30b14ef194d54952fdf2c2ffe592e406"
  # Pinned explicitly: Homebrew mis-parses the "-fork.N" tag down to a bare "1".
  version "1.12.0-fork.1"

  head "https://github.com/sdthach/git-toolbelt.git", branch: "main"

  # git-relative-path needs GNU realpath; native on Linux, provided here for macOS.
  depends_on "coreutils"

  def install
    bin.install Dir["git-*"]          # the ~62 git-<verb> subcommands
    bin.install Dir["portmanteaus/*"] # the g+verb shortcuts (getch, gush, gome, ...)
  end

  test do
    # A git-* subcommand and a portmanteau shortcut both landed on PATH.
    assert_path_exists bin/"git-main-branch"
    assert_path_exists bin/"getch"

    # git-main-branch actually resolves the main branch. Force the default branch
    # name and add a commit so the probe has a real branch to find, independent of
    # the ambient init.defaultBranch (brew's sandbox leaves it as "master").
    ENV.prepend_path "PATH", bin
    system "git", "-C", testpath, "-c", "init.defaultBranch=main", "init", "-q"
    system "git", "-C", testpath, "-c", "user.name=brew", "-c", "user.email=brew@example.com",
           "commit", "-q", "--allow-empty", "-m", "init"
    assert_equal "main", shell_output("git -C #{testpath} main-branch").strip
  end
end
