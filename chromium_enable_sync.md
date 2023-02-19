### Install Chromium

```bash
$ brew install --cask chromium
```

### Patch launcher

```bash
$ cd /Applications/Chromium.app/Contents/MacOS

$ mv Chromium chrome_exec

$ cat << EOF > Chromium
#!/bin/bash

export GOOGLE_API_KEY=""
export GOOGLE_DEFAULT_CLIENT_ID="77185425430.apps.googleusercontent.com"
export GOOGLE_DEFAULT_CLIENT_SECRET="OTJgUOQcT7lO7GsGZq2G4IlT"

exec /Applications/Chromium.app/Contents/MacOS/chrome_exec "$@"
EOF

$ chmod +x Chromium
```


