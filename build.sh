#!/bin/bash

# --- CONFIGURATION ---
APP_NAME="git-prompt"
VERSION="1.0.0"
MAINTAINER="Forz70043 <info@pisicchio.dev>"
DESCRIPTION="Ultra-fast git branch indicator for shell prompt written in Go."

echo "🚀 Starting build process for $APP_NAME v$VERSION..."

# 1. Clean and create folder structure
echo "📁 Preparing folders..."
rm -rf pkg
mkdir -p pkg/DEBIAN
mkdir -p pkg/usr/local/bin

# 2. Go compilation
echo "🐹 Compiling Go source..."
go build -o pkg/usr/local/bin/$APP_NAME main.go

# 3. Generate metadata file (control)
echo "📝 Generating DEBIAN/control file..."
cat <<EOF > pkg/DEBIAN/control
Package: $APP_NAME
Version: $VERSION
Section: utils
Priority: optional
Architecture: amd64
Depends: git
Maintainer: $MAINTAINER
Description: $DESCRIPTION

EOF

# 4. Generate post-installation script (postinst)
echo "📜 Generating post-installation script..."
cat <<'EOF' > pkg/DEBIAN/postinst
#!/bin/bash
set -e
BIN_NAME="git-prompt"

PROMPT_CODE='export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]\$('$BIN_NAME')\[\033[00m\] \$ "'

inject_prompt() {
    local target_file="$1"
    if [ -f "$target_file" ] && ! grep -q "$BIN_NAME" "$target_file"; then
        echo -e "\n# Git Prompt Integration\n$PROMPT_CODE" >> "$target_file"
        echo "✅ Prompt added to $target_file"
    fi
}

# Injection global for the system
inject_prompt "/etc/bash.bashrc"

# Injection for the real user who ran sudo
if [ -n "$SUDO_USER" ]; then
    REAL_USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
    if [ -n "$REAL_USER_HOME" ]; then
        inject_prompt "$REAL_USER_HOME/.bashrc"
    fi
fi

exit 0
EOF

# 5. Configuration of Permissions
echo "🔐 Configuring permissions..."
chmod 755 pkg/DEBIAN/postinst
chmod 755 pkg/usr/local/bin/$APP_NAME

# 6. Building the .deb package
echo "📦 Building .deb package..."
dpkg-deb --build pkg ${APP_NAME}.deb

echo "---"
echo "✅ Build completed successfully!"
echo "📦 File generated: ${APP_NAME}.deb"
echo "👉 Install with: sudo apt install ./${APP_NAME}.deb"