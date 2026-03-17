package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func main() {
	// Exec command for branch
	out, err := exec.Command("git", "rev-parse", "--abbrev-ref", "HEAD").Output()
	
	// If err != nil not repository git
	if err != nil {
		return
	}

	branch := strings.TrimSpace(string(out))
	
	if branch != "" {
		fmt.Printf("(git:%s)", branch)
	}
}