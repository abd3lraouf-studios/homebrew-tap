# abd3lraouf Studios — Homebrew Tap

Official Homebrew tap for apps by [abd3lraouf Studios](https://github.com/abd3lraouf-studios).

## Install any app from this tap

```bash
brew install --cask abd3lraouf-studios/tap/<app-name>
```

Or, tap once and install by short name:

```bash
brew tap abd3lraouf-studios/tap
brew install --cask <app-name>
```

Command-line tools are formulae, not casks — install those without `--cask`:

```bash
brew install abd3lraouf-studios/tap/<tool-name>
```

## Available apps

_None right now._

PrayerTimes used to be distributed here. It now ships exclusively through the
[Mac App Store](https://apps.apple.com/app/id6763390896), so its cask is
disabled and `brew install --cask prayertimes` will tell you where to go. The
file stays in `Casks/` so that anyone who still has it installed can
`brew uninstall` and `brew zap` cleanly.

## Available command-line tools

| Tool | Install | Description |
|---|---|---|
| **[macos-touchid-sudo](https://github.com/abd3lraouf-studios/macos-touchid-sudo)** | `brew install abd3lraouf-studios/tap/macos-touchid-sudo` | Authenticate `sudo` with Touch ID, including inside tmux |

## Update installed apps

```bash
brew upgrade --cask <app-name>
```

## Uninstall

```bash
brew uninstall --cask <app-name>
```

## For maintainers — adding a new cask

1. Create `Casks/<app-name>.rb` with the standard Homebrew cask DSL:

   ```ruby
   cask "myapp" do
     version "1.0.0"
     sha256 "<sha256 of the .dmg>"

     url "https://github.com/abd3lraouf-studios/MyApp/releases/download/v#{version}/MyApp-#{version}.dmg"
     name "MyApp"
     desc "One-line description"
     homepage "https://github.com/abd3lraouf-studios/MyApp"

     livecheck do
       url :url
       strategy :github_latest
     end

     depends_on :macos

     app "MyApp.app"

     uninstall quit: "dev.abd3lraouf.MyApp"

     zap trash: [
       "~/Library/Containers/dev.abd3lraouf.MyApp",
       "~/Library/Preferences/dev.abd3lraouf.MyApp.plist",
     ]
   end
   ```

   Keep to that DSL. In particular, a cask installs an app — it does not run
   one. No `postflight` that calls `open`, and no `xattr -d com.apple.quarantine`:
   stripping quarantine defeats Gatekeeper, and a properly notarized build does
   not need it. Anything the user must opt into belongs in `caveats`, the way
   `Formula/macos-touchid-sudo.rb` asks them to run `sudo touchid-sudo`
   themselves rather than editing `/etc/pam.d/sudo` at install time.

   Likewise, leave user data alone on uninstall. `uninstall` removes the app;
   `zap` removes preferences, caches and containers. Deleting a prefs domain or
   resetting TCC in an `uninstall_postflight` breaks that split — someone who
   uninstalls and reinstalls expects their settings to survive.

2. Validate locally before pushing:

   ```bash
   brew audit --cask --new Casks/<app-name>.rb
   brew style Casks/<app-name>.rb
   ```

3. Each app's release workflow should bump its own cask here on tag push. See
   [PrayerTimes/.github/workflows/release.yml](https://github.com/abd3lraouf-studios/PrayerTimes/blob/main/.github/workflows/release.yml)
   for a working example.

4. Add an entry to the **Available apps** table above.

## For maintainers — adding a new command-line tool

Formulae go in `Formula/<tool-name>.rb` and build from a source tarball rather
than a `.dmg`:

```ruby
class MyTool < Formula
  desc "One-line description"
  homepage "https://github.com/abd3lraouf-studios/my-tool"
  url "https://github.com/abd3lraouf-studios/my-tool/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "<shasum -a 256 of the tarball>"
  license "MIT"

  def install
    bin.install "bin/my-tool"
  end

  test do
    assert_match "my-tool", shell_output("#{bin}/my-tool --version")
  end
end
```

Validate the same way, minus the cask flag:

```bash
brew audit --new --formula Formula/<tool-name>.rb
brew style Formula/<tool-name>.rb
brew install --build-from-source Formula/<tool-name>.rb
brew test <tool-name>
```

Then add a row to the **Available command-line tools** table.

## License

Each cask references the licensing of its upstream app. Cask files themselves
are licensed under the [BSD 2-Clause License](LICENSE), the same license used
by Homebrew core.
