# Based on https://github.com/Homebrew/homebrew-core/blob/2012c47103c8ffa9c18e3e584f6df9ed5450a385/Formula/k/kubernetes-cli.rb
# Install based on https://skerritt.blog/packaging-your-rust-code/
class NextlessCli < Formula
  desc "CLI tool to interact with a Nextless Controller"
  homepage "https://github.com/edgeless-project/nextless/tree/development/edgeless_cli"
  url "https://github.com/edgeless-project/nextless.git",
    tag:      "cli-3.0.0",
    revision: "1117467dba55847012ac709af66c575bf2a56971"
  license "MIT"
  head "https://github.com/edgeless-project/nextless.git", branch: "development"

  bottle do
    root_url "https://github.com/edgeless-project/homebrew-edgeless/releases/download/nextless-cli-3.0.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "806a23a4684bde84f51ba57d2d074988fd280dbb941c452d0231ac2d137758eb"
  end

  depends_on "protobuf" => :build
  depends_on "rust" => :build
  depends_on "openssl@3"
  depends_on "binaryen" => :recommended
  depends_on "rustup" => :recommended

  def install
    # Brew does not allow disabling the "cargo install *std_cargo_args bot, but we can't use their std cargo args.
    # This variable hides our crimes from RuboCop.
    cargo_command = "cargo"
    system cargo_command, "build", "--release", "--bin", "edgeless_cli"
    bin.install "target/release/edgeless_cli" => "nextless_cli_raw"
    bin.install "edgeless_cli/cli_wrapper.sh" => "nextless_cli"
  end
end
