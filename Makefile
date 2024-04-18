stow:
	@stow nvim/ -t ~/.config/nvim

stow-alacritty:
	@stow alacritty/ -t ~/.config/alacritty

stow-tmux:
	@rm ~/.tmux.conf
	@cp ~/.config/dotfiles/tmuxconf/.tmux.conf ~

stow-all: stow stow-alacritty stow-tmux
