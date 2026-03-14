#!/bin/bash

# 1. Clean and create structure
rm -rf pkg
mkdir -p pkg/DEBIAN
mkdir -p pkg/usr/local/bin

# 2. Go compilation
go build -o pkg/usr/local/bin/wild-prompt main.go

# 3. File control
cat <<EOF > pkg/DEBIAN/control
Package: wild-prompt
Version: 1.0.0
Section: utils
Priority: optional
Architecture: amd64
Maintainer: Forz70043 <info@pisicchio.dev>
Description: Ultra-fast git branch indicator for shell prompt written in Go.

EOF

# 4. Creation of the postinst script to modify the PS1 variable in /etc/bash.bashrc
cat <<'EOF' > pkg/DEBIAN/postinst
#!/bin/bash
PROMPT_LINE='export PS1="\[\e[36m\]\u@\h\[\e[m\]:\[\e[34m\]\w\[\e[33m\]\$(wild-prompt)\[\e[m\] \$ "'
if [ -f "/etc/bash.bashrc" ]; then
    if ! grep -q "wild-prompt" "/etc/bash.bashrc"; then
        echo -e "\n# Wild Prompt\n$PROMPT_LINE" >> "/etc/bash.bashrc"
    fi
fi
EOF

# 5. SET PERMISSION
chmod 755 pkg/DEBIAN/postinst
chmod 755 pkg/usr/local/bin/wild-prompt

# 6. Build of the package
dpkg-deb --build pkg wild-prompt.deb

echo "✅ Package auto-installer generated!"