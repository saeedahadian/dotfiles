cd $(pwd)/alacritty && cargo build --release && cd -
sudo ln -s $(pwd)/alacritty/target/release/alacritty /usr/local/bin
sudo ln -s $(pwd)/alacritty/extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install $(pwd)/alacritty/extra/linux/Alacritty.desktop
sudo update-desktop-database

ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.zsh_functions ~/.zsh_functions
