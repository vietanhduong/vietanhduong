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

Script for start emacs form terminal:
```bash
#!/bin/bash

if [ "$1" == "help" ] || [ "$1" == " — help" ] || [ "$1" == "-h" ]; then
 echo "A dumb script to deal with Emacs Client Frame"
 echo "Open a file in the existing frame or create a frame if none"
 echo "If multiple frames are open, the file will be opened in the last focused frame"
 echo ""
 echo "usage: em <name of file> [w]"
 echo " — \"w\" forces the creation of a frame even if there is already one"
exit
fi

state="$(emacsclient -qn -e "(if (> (length (frame-list)) 1) 't)")"
if [ "$state" == "" ] || [ "$state" == "nil" ] || [ "$2" == "w" ] ; then
 emacsclient -a '' -cqn $1
else
 emacsclient -qn $1
fi
```

Make sure you grained execute mode for this file `chmod +x ec`. You should place in `/usr/local/bin`.

### Fix not found emacs in spotlight

1. Open emacs folder. `open /usr/local/Cellar/[emacs-version]`
2. Right click on `Emacs.app` >> Make alias
3. Move the alias to `Applications` folder.

Done!

### Create AppleScript
```AppleScript
try
	tell application "Terminal"
		do shell script "/usr/local/bin/ec"
	end tell
on error
	tell application "Terminal"
		do shell script "/usr/local/bin/emacs --daemon"
		do shell script "/usr/local/bin/ec"
	end tell
end try
```