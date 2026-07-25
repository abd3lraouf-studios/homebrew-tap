# App Builders Gang — Homebrew Tap

Official Homebrew tap for apps by [App Builders Gang](https://github.com/App-Builders-Gang).

## Install any app from this tap

```bash
brew install --cask App-Builders-Gang/tap/<app-name>
```

Or, tap once and install by short name:

```bash
brew tap App-Builders-Gang/tap
brew install --cask <app-name>
```

Command-line tools are formulae, not casks — install those without `--cask`:

```bash
brew install App-Builders-Gang/tap/<tool-name>
```

## Available apps

| App | Install | Description |
|---|---|---|
| **[PrayerTimes](https://github.com/App-Builders-Gang/PrayerTimes)** | `brew install --cask App-Builders-Gang/tap/prayertimes` | Prayer times in your Mac's menu bar |

## Available command-line tools

| Tool | Install | Description |
|---|---|---|
| **[macos-touchid-sudo](https://github.com/App-Builders-Gang/macos-touchid-sudo)** | `brew install App-Builders-Gang/tap/macos-touchid-sudo` | Authenticate `sudo` with Touch ID, including inside tmux |

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

     url "https://github.com/App-Builders-Gang/MyApp/releases/download/v#{version}/MyApp-#{version}.dmg"
     name "MyApp"
     desc "One-line description"
     homepage "https://github.com/App-Builders-Gang/MyApp"

     livecheck do
       url :url
       strategy :github_latest
     end

     app "MyApp.app"

     uninstall quit: "dev.abd3lraouf.MyApp"

     zap trash: [
       "~/Library/Containers/dev.abd3lraouf.MyApp",
       "~/Library/Preferences/dev.abd3lraouf.MyApp.plist",
     ]
   end
   ```

2. Validate locally before pushing:

   ```bash
   brew audit --cask --new Casks/<app-name>.rb
   brew style Casks/<app-name>.rb
   ```

3. Each app's release workflow should bump its own cask here on tag push. See
   [PrayerTimes/.github/workflows/release.yml](https://github.com/App-Builders-Gang/PrayerTimes/blob/main/.github/workflows/release.yml)
   for a working example.

4. Add an entry to the **Available apps** table above.

## For maintainers — adding a new command-line tool

Formulae go in `Formula/<tool-name>.rb` and build from a source tarball rather
than a `.dmg`:

```ruby
class MyTool < Formula
  desc "One-line description"
  homepage "https://github.com/App-Builders-Gang/my-tool"
  url "https://github.com/App-Builders-Gang/my-tool/archive/refs/tags/v1.0.0.tar.gz"
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
