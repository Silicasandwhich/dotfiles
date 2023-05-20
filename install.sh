#!/usr/bin/env bash
echo "+---------------------------------------+"
echo "| SILICASANDWHICH'S LINUX CONFIGURATION |"
echo "+---------------------------------------+"

echo -n "install config files? (Y/n)"
read answer
lowerAnswer=${answer,,}
if [ ${lowerAnswer:0:1} = 'n' ]; then
	echo "exiting..."
	exit 0
fi

echo "installing packages..."

packagesNeeded="$(cat pkglist)"

if [ -x "$(command -v apk)" ];       then sudo apk add --no-cache $packagesNeeded
elif [ -x "$(command -v apt-get)" ]; then sudo apt-get install $packagesNeeded
elif [ -x "$(command -v dnf)" ];     then sudo dnf install $packagesNeeded
elif [ -x "$(command -v zypper)" ];  then sudo zypper install $packagesNeeded
elif [ -x "$(command -v pacman)" ]; then sudo pacman -Syu $packagesNeeded
else
	echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: $packagesNeeded">&2
	echo -n "Are all requisite packages installed? (Y/n)"
	read answer
	lowerAnswer=${answer,}
	if [ ${lowerAnswer:0:1} = 'n' ]; then
		echo "exiting..."
		exit 0
	fi
fi


echo "installing starship..."
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/LiberationMono.zip
unzip -qd font LiberationMono.zip.2
sudo cp font/* /usr/share/fonts
fc-cache -vf

curl -sS https://starship.rs/install.sh | sh

echo "setting up oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "DONE"

echo "setting user shell to zsh..."
chsh --shell /bin/zsh $USER
echo "DONE"

echo -n "moving config files..."
cp -r .vim ~
cp -r nvim ~/.config
cp -r starship.toml ~/.config
cp .zshrc ~
cp .vimrc ~
cp -r oh-my-zsh/* ~/.oh-my-zsh/custom/
echo "DONE"

echo "Installation finished!"



