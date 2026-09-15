cask "prayertimes" do
  version "4.6.0"
  sha256 "d1635becdad9147b5ac2c32a2a8d797573b7efdf1c4b70cb6f601c76f8b89ecf"

  url "https://github.com/abd3lraouf-studios/PrayerTimes/releases/download/v#{version}/PrayerTimes-#{version}.dmg"
  name "PrayerTimes"
  desc "Menu bar app for Islamic prayer times with Hijri calendar"
  homepage "https://github.com/abd3lraouf-studios/PrayerTimes"

  depends_on :macos

  app "PrayerTimes.app"

  uninstall quit:       "dev.abd3lraouf.PrayerTimes",
            login_item: "PrayerTimes"

  zap trash: [
    "~/Library/Caches/dev.abd3lraouf.PrayerTimes",
    "~/Library/Containers/dev.abd3lraouf.PrayerTimes",
    "~/Library/HTTPStorages/dev.abd3lraouf.PrayerTimes",
    "~/Library/Preferences/dev.abd3lraouf.PrayerTimes.plist",
    "~/Library/Saved Application State/dev.abd3lraouf.PrayerTimes.savedState",
  ]
end
