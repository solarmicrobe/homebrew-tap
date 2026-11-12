class Ghq < Formula
  desc "Remote repository management made easy"
  homepage "https://github.com/solarmicrobe/ghq"
  version "1.10.1+ignore-host.symlink"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/solarmicrobe/ghq/releases/download/v1.10.1+ignore-host.symlink/ghq_darwin_arm64.zip"
      sha256 "7f1e1e6410369e0c72c55be894bd14f0c1a588b05d61542c6de7dd0b71750a74"
    end

    on_intel do
      url "https://github.com/solarmicrobe/ghq/releases/download/v1.10.1+ignore-host.symlink/ghq_darwin_amd64.zip"
      sha256 "7e7017711d02eba7804217bc8edff6b7b773bd7dee581f6321be16caaa7c5a0f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/solarmicrobe/ghq/releases/download/v1.10.1+ignore-host.symlink/ghq_linux_arm64.zip"
      sha256 "bb9f4d263435c2752d481b65680277183e0905fa65bd7e6dbb4d35b38873e8f1"
    end

    on_intel do
      url "https://github.com/solarmicrobe/ghq/releases/download/v1.10.1+ignore-host.symlink/ghq_linux_amd64.zip"
      sha256 "6c2bca4492f7d10ea2265139fa382513fb4084d596a7faac34b1043540d4337c"
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
