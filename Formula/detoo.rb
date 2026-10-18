# The Homebrew formula for detoo.  The Release workflow fills in 0.3.0 and
# 0f875c73020cdd1c21d32ef8c84e83c1d054d22dcd65ff973996445efc630e56 for each release, and publishes the result to
# https://github.com/mustardcustarddev/homebrew-tap, as Formula/detoo.rb.
class Detoo < Formula
  desc "Command-line tools and agentic skills for working with decision records"
  homepage "https://mustardcustarddev.github.io/detoo/"
  url "https://github.com/mustardcustarddev/detoo/releases/download/v0.3.0/detoo_0.3.0_darwin_arm64.tar.gz"
  sha256 "0f875c73020cdd1c21d32ef8c84e83c1d054d22dcd65ff973996445efc630e56"
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
    assert_path_exists testpath/"docs/userstory/STORY-0001-describe-work-in-user-stories.md"
  end
end
