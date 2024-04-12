# -*- Makefile -*-

config:
	yq -o json powerline.yaml | jq -r .config > ~/.config/powerline-shell/config.json

.PHONY: config
