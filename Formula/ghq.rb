class Ghq < Formula
  desc "Remote repository management made easy"
  homepage "https://github.com/solarmicrobe/ghq"
  version "1.10.1-solarmicrobe.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/solarmicrobe/ghq/releases/download/v1.10.1-solarmicrobe.2/ghq_darwin_arm64.zip"
      sha256 "952986907416faa977122e6b97d76b26572496660712c5f864814efcc32981fa"
    end

    on_intel do
      url "https://github.com/solarmicrobe/ghq/releases/download/v1.10.1-solarmicrobe.2/ghq_darwin_amd64.zip"
      sha256 "207c69b1376b39b8a419acb7e7c10a1ac79e548f430e747935977055a8812551"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/solarmicrobe/ghq/releases/download/v1.10.1-solarmicrobe.2/ghq_linux_arm64.zip"
      sha256 "914e74a2885287b54e06df5c2ff3726a4b4222e92860eebe7e0dbe68c6006f69"
    end

    on_intel do
      url "https://github.com/solarmicrobe/ghq/releases/download/v1.10.1-solarmicrobe.2/ghq_linux_amd64.zip"
      sha256 "9025a239ab98ade0308991c7733bbd6e22489e75831f9123a207c0a2237bdd4f"
    end
  end

  conflicts_with "ghq", because: "both install a ghq binary"

  def install
    archive_dir = Dir["ghq_*"].first

    bin.install "#{archive_dir}/ghq"
    bash_completion.install "#{archive_dir}/misc/bash/_ghq"
    zsh_completion.install "#{archive_dir}/misc/zsh/_ghq"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ghq --version")
  end
end
