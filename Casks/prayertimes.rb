cask "prayertimes" do
  version "3.2.0"
  sha256 "65e0f2a12e92e39345f883257c345ca5ff74d614b3f813f575bcd7c9d473430f"

  url "https://github.com/abd3lraouf-studios/PrayerTimes/releases/download/v#{version}/PrayerTimes-#{version}.dmg"
  name "PrayerTimes"
  desc "Menu bar app for Islamic prayer times with Hijri calendar"
  homepage "https://github.com/abd3lraouf-studios/PrayerTimes"

  disable! date: "2026-08-16", because: :moved_to_mas

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
