stow:
	@stow nvim/ -t ~/.config/nvim

stow-alacritty:
	@stow alacritty/ -t ~/.config/alacritty

stow-tmux:
	@stow tmuxconf/ -t ~/

stow-all: stow stow-alacritty stow-tmux
