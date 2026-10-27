cask "bucket" do
  version "0.4.0"
  sha256 "f5943d27f286153ccce6ec0622d07dd03d4097e4ecd51fbc9704ba881b55fbea"

  url "https://github.com/geheime/bucket/releases/download/v#{version}/Bucket-#{version}.zip"
  name "Bucket"
  desc "Menu bar app that hands your screenshots to your terminal AI agent"
  homepage "https://github.com/geheime/bucket"

  depends_on macos: :sonoma

  app "Bucket.app"
  # `bucket search "<words>" --json` from any shell; the app binary is also the CLI.
  binary "#{appdir}/Bucket.app/Contents/MacOS/Bucket", target: "bucket"

  # ~/Bucket holds the user's screenshots and is never removed, not even by zap.
  zap trash: "~/Library/Preferences/studio.bast.bucket.plist"

  caveats <<~EOS
    Bucket is open source but not notarized, so macOS blocks the first launch once:
      open #{appdir}/Bucket.app
      then System Settings > Privacy & Security > Open Anyway.

    Then allow Screen Recording when Bucket asks, and turn off the macOS Cmd+Shift+4
    shortcut (System Settings > Keyboard > Keyboard Shortcuts > Screenshots).

    The Claude Code skill is in:
      #{staged_path}/integrations/claude-code/bucket-search
  EOS
end
