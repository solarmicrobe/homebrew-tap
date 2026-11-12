#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "open-uri"

tag = ARGV.fetch(0) do
  abort "usage: #{$PROGRAM_NAME} vX.Y.Z+feature.feature"
end

unless tag.match?(/\Av\d+\.\d+\.\d+(?:\+[0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*|-solarmicrobe\.\d+)\z/)
  abort "tag must look like vX.Y.Z+feature.feature: #{tag}"
end

version = tag.delete_prefix("v")
base_url = "https://github.com/solarmicrobe/ghq/releases/download/#{tag}"

assets = {
  darwin_arm64: "ghq_darwin_arm64.zip",
  darwin_amd64: "ghq_darwin_amd64.zip",
  linux_arm64: "ghq_linux_arm64.zip",
  linux_amd64: "ghq_linux_amd64.zip"
}

def sha256_for(url)
  URI.open(url, "rb") do |io|
    digest = Digest::SHA256.new
    buffer = +""
    digest.update(buffer) while io.read(1024 * 1024, buffer)
    digest.hexdigest
  end
end

sha256 = assets.transform_values { |asset| sha256_for("#{base_url}/#{asset}") }

formula = <<~RUBY
  class Ghq < Formula
    desc "Remote repository management made easy"
    homepage "https://github.com/solarmicrobe/ghq"
    version "#{version}"
    license "MIT"

    on_macos do
      on_arm do
        url "#{base_url}/#{assets[:darwin_arm64]}"
        sha256 "#{sha256[:darwin_arm64]}"
      end

      on_intel do
        url "#{base_url}/#{assets[:darwin_amd64]}"
        sha256 "#{sha256[:darwin_amd64]}"
      end
    end

    on_linux do
      on_arm do
        url "#{base_url}/#{assets[:linux_arm64]}"
        sha256 "#{sha256[:linux_arm64]}"
      end

      on_intel do
        url "#{base_url}/#{assets[:linux_amd64]}"
        sha256 "#{sha256[:linux_amd64]}"
      end
    end

    conflicts_with "ghq", because: "both install a ghq binary"

    def install
      archive_dir = Dir["ghq_*"].first

      bin.install "\#{archive_dir}/ghq"
      bash_completion.install "\#{archive_dir}/misc/bash/_ghq"
      zsh_completion.install "\#{archive_dir}/misc/zsh/_ghq"
    end

    test do
      assert_match version.to_s, shell_output("\#{bin}/ghq --version")
    end
  end
RUBY

File.write("Formula/ghq.rb", formula)
