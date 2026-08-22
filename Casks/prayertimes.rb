cask "prayertimes" do
  version "3.3.0"
  sha256 "069ff0768a7aff86d4ba8e85cb80bf0b8670105e326ddaac442712e554faf2ed"

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
