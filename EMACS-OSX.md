### Install emacs

```bash
$ brew tap d12frosted/emacs-plus
$ brew install emacs-plus 
```
Make sure you linked `Emacs.app` to `/Applications` folder.

### Auto startup emacs server

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>my.Emacs</string>
    <key>ProgramArguments</key>
    <array>
      <string>/Applications/Emacs.app/Contents/MacOS/emacs</string>
      <string>--daemon</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
  </dict>
</plist>
```

To `load` script. Run commend below:

```bash
$ launchctl load -w ~/Library/LaunchAgents/my.emacs.plist
```

To `unload`:

```bash
$ launchctl unload -w ~/Library/LaunchAgents/my.emacs.plist
``` 

