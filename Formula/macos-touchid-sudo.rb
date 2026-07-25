class MacosTouchidSudo < Formula
  desc "Authenticate sudo with Touch ID on macOS, including inside tmux"
  homepage "https://github.com/App-Builders-Gang/macos-touchid-sudo"
  url "https://github.com/App-Builders-Gang/macos-touchid-sudo/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "cd0e761b660e9f24a636d4668270379c759782e5c41bc842eaf091afdb8bf711"
  license "MIT"
  head "https://github.com/App-Builders-Gang/macos-touchid-sudo.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on macos: :sonoma

  # pam-reattach is deliberately not a dependency: it is only needed for Touch
  # ID inside tmux/screen, and the command detects it at runtime. See caveats.

  def install
    bin.install "bin/touchid-sudo"
  end

  def caveats
    <<~EOS
      Enable Touch ID for sudo (asks for your password once):
        sudo touchid-sudo

      Check the current state at any time:
        touchid-sudo --status

      For Touch ID inside tmux or screen, also install pam-reattach and re-run:
        brew install pam-reattach
        sudo touchid-sudo

      To revert to password-only authentication:
        sudo touchid-sudo --disable
    EOS
  end

  test do
    assert_match "touchid-sudo #{version}", shell_output("#{bin}/touchid-sudo --version")
    assert_match "Touch ID for sudo", shell_output("#{bin}/touchid-sudo --status")
    assert_match "enable Touch ID", shell_output("#{bin}/touchid-sudo --help")
  end
end
