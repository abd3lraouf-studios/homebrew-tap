cask "prayertimes" do
  version "3.1.0"
  sha256 "57f286d48142412d1da5376d0a69318a0b793f908580123ad31681abe896fa82"

  url "https://github.com/abd3lraouf-studios/PrayerTimes/releases/download/v#{version}/PrayerTimes-#{version}.dmg"
  name "PrayerTimes"
  desc "Menu bar app for Islamic prayer times with Hijri calendar"
  homepage "https://github.com/abd3lraouf-studios/PrayerTimes"

  disable! date: "2026-08-16", because: :moved_to_mas

  app "PrayerTimes.app"

  uninstall_preflight do
    # Reset all permissions (location, notifications, etc.) while app is still registered
    system_command "/usr/bin/tccutil",
                   args: ["reset", "All", "dev.abd3lraouf.PrayerTimes"],
                   sudo: false
  end

  uninstall quit:       "dev.abd3lraouf.PrayerTimes",
            login_item: "PrayerTimes"

  uninstall_postflight do
    # Flush cfprefsd cached preferences domain
    system_command "/usr/bin/defaults",
                   args: ["delete", "dev.abd3lraouf.PrayerTimes"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Containers/dev.abd3lraouf.PrayerTimes",
    "~/Library/Preferences/dev.abd3lraouf.PrayerTimes.plist",
    "~/Library/Saved Application State/dev.abd3lraouf.PrayerTimes.savedState",
    "~/Library/HTTPStorages/dev.abd3lraouf.PrayerTimes",
    "~/Library/Caches/dev.abd3lraouf.PrayerTimes",
  ]
end
