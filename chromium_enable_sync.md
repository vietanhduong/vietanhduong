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

export GOOGLE_API_KEY="<API_KEY>"
export GOOGLE_DEFAULT_CLIENT_ID="<OAUTH2_CLIENT_ID>"
export GOOGLE_DEFAULT_CLIENT_SECRET="<OAUTH2_CLIENT_SECRET>"

exec /Applications/Chromium.app/Contents/MacOS/chrome_exec "$@"
EOF

$ chmod +x Chromium
```


