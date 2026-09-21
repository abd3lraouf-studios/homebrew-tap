cask "prayertimes" do
  version "4.10.2"
  sha256 "80b84dc2b9c51319010ed2b8c38f4a6f28b8870e8d8791bbb3c55ed2f75c6c95"

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
