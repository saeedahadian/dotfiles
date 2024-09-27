cd $(pwd)/alacritty && cargo build --release && cd -
sudo ln -s $(pwd)/alacritty/target/release/alacritty /usr/local/bin
sudo ln -s $(pwd)/alacritty/extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install $(pwd)/alacritty/extra/linux/Alacritty.desktop
sudo update-desktop-database

mkdir -p ~/.config/alacritty
ln -s $(pwd)/alacritty.toml ~/.config/alacritty/alacritty.toml

mkdir -p ~/.config/phpactor
ln -s $(pwd)/phpactor.json ~/.config/phpactor/phpactor.json

ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.zsh_functions ~/.zsh_functions

ln -s $(pwd)/powerlevel10k/powerlevel10k.zsh-theme $(pwd)/.zsh_functions/powerlevel10k.zsh-theme
ln -s $(pwd)/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh $(pwd)/.zsh_functions/zsh-syntax-highlighting.zsh

ln -s $(pwd)/.tmux.conf ~/.tmux.conf

ln -s $(pwd)/nvim ~/.config/nvim

ln -s $(pwd)/.aliases ~/.aliases
