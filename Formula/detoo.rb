# The Homebrew formula for detoo.  The Release workflow fills in 0.5.1 and
# 413da8c7ee42cb013cc81c17380409c971ddfbc07f9c9998009215345d64388b for each release, and publishes the result to
# https://github.com/mustardcustarddev/homebrew-tap, as Formula/detoo.rb.
class Detoo < Formula
  desc "Command-line tools and agentic skills for working with decision records"
  homepage "https://mustardcustarddev.github.io/detoo/"
  url "https://github.com/mustardcustarddev/detoo/releases/download/v0.5.1/detoo_0.5.1_darwin_arm64.tar.gz"
  sha256 "413da8c7ee42cb013cc81c17380409c971ddfbc07f9c9998009215345d64388b"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # The release has prebuilt commands for Apple silicon Macs only.
  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install Dir["bin/*"]
    # Each command is built with Cobra, and writes its own completion for bash,
    # zsh, fish and PowerShell.
    bin.children.each do |command|
      generate_completions_from_executable(command, shell_parameter_format: :cobra)
    end
  end

  test do
    system bin/"ust", "init"
    assert_path_exists testpath/"docs/userstory/README.md"
  end
end
