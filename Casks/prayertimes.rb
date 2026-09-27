cask "prayertimes" do
  version "5.1.0"
  sha256 "fdab3faf80841206df7093fb02f53b393d4b70b06efc9b1af6bff5b8f989f925"

  url "https://github.com/abd3lraouf-studios/PrayerTimes/releases/download/v#{version}/PrayerTimes-#{version}.dmg"
  name "PrayerTimes"
  desc "Menu bar app for Islamic prayer times with Hijri calendar"
  homepage "https://github.com/abd3lraouf-studios/PrayerTimes"

  depends_on :macos

  app "PrayerTimes.app"

  uninstall quit:       "dev.abd3lraouf.PrayerTimes",
            login_item: "PrayerTimes"

  caveats <<~EOS
    PrayerTimes is a Mac app, not a terminal command.
    Open it with `open -a PrayerTimes` or from Applications.
  EOS

  zap trash: [
    "~/Library/Caches/dev.abd3lraouf.PrayerTimes",
    "~/Library/Containers/dev.abd3lraouf.PrayerTimes",
    "~/Library/HTTPStorages/dev.abd3lraouf.PrayerTimes",
    "~/Library/Preferences/dev.abd3lraouf.PrayerTimes.plist",
    "~/Library/Saved Application State/dev.abd3lraouf.PrayerTimes.savedState",
  ]
end
