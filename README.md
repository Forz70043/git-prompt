# 🚀 Git Prompt

Git Prompt is an ultra-fast, minimal Git branch indicator for your Linux shell, written in Go.

Stop using heavy Bash scripts that lag your terminal. Git Prompt is a compiled binary that ensures near-zero latency, showing you exactly where you are in your Git repository without any overhead.

## ✨ Features

⚡ Extreme Performance: Built with Go for sub-millisecond execution.

📦 Zero-Effort Installation: Packaged as a .deb file that automatically configures your shell.

🧼 Clean Design: No weird icons or special Nerd Fonts required. It works on any terminal, out of the box.

🧠 Context Aware: Only appears when you are inside a Git repository. It stays hidden otherwise.

## 📸 Preview

Inside a Git repository:
    
    user@linux:~/projects/my-app (git:main) $

Outside a Git repository:
    
    user@linux:~/Documents $

## 🛠️ Quick Installation

The easiest way to install git Prompt on Ubuntu, Debian, or WSL is using the pre-compiled package.

Download the Package:
    
Get the latest git-prompt.deb from the Releases section.

Install via APT:

    sudo apt install ./git-prompt.deb

Refresh your Terminal:

    source ~/.bashrc

The installer automatically updates your /etc/bash.bashrc to integrate the prompt.

## 🏗️ Build from Source

If you want to compile it yourself:

Ensure you have Go installed (go version).

Clone the repository:

    git clone https://github.com/Forz70043/git-prompt.git
    cd git-prompt

Run the build script:

    chmod +x build.sh
    ./build.sh

## 📋 Technical Specs

Language: Go 1.20+

Target: Linux (x86_64)

Shell Support: Bash (Zsh support coming soon)

License: MIT

## 🤝 Contributing

Pull requests are welcome! If you have ideas for better formatting or new features (like file status indicators), feel free to open an Issue.

Made with ❤️ by Forz70043