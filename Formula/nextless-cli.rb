# Based on https://github.com/Homebrew/homebrew-core/blob/2012c47103c8ffa9c18e3e584f6df9ed5450a385/Formula/k/kubernetes-cli.rb
# Install based on https://skerritt.blog/packaging-your-rust-code/
class NextlessCli < Formula
  desc "CLI tool to interact with a Nextless Controller"
  homepage "https://github.com/edgeless-project/nextless/tree/development/edgeless_cli"
  url "https://github.com/edgeless-project/nextless.git",
    tag:      "cli-0.1-wrapper2",
    revision: "163587e16d8073df7706b21f1bdf50640782c962"
  license "MIT"
  head "https://github.com/edgeless-project/nextless.git", branch: "development"

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
