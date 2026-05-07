cask "prayertimes" do
  version "1.1.0"
  sha256 "b9d73fa65a7d71316682ce811689fe47c02a79c53ed432755d6c758be5a812b0"

  url "https://github.com/App-Builders-Gang/PrayerTimes/releases/download/v#{version}/PrayerTimes-#{version}.dmg"
  name "PrayerTimes"
  desc "Menu bar app for Islamic prayer times with Hijri calendar"
  homepage "https://github.com/App-Builders-Gang/PrayerTimes"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "PrayerTimes.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", "#{appdir}/PrayerTimes.app"],
                   sudo: false
    system_command "/usr/bin/open",
                   args: ["#{appdir}/PrayerTimes.app"],
                   sudo: false
  end

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

