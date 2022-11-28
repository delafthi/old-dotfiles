# delafthi's dotfiles

## Table of content

- [Installation](#Installation)
- [Management](#Management)
- [Configurations](#Configurations)

## Installation

1. Clone the repository to your home folder

```sh
git clone https://github.com/delafthi/dotfiles ~/dotfiles
```

2. Install stow

```sh
# On arch
sudo pacman -S stow
# On debian
suda apt install stow
# On fedora
yum install stow
```
3. Change into the cloned directory and symlink the configurations you want with
   stow.

```sh
cd ~/dotfiles
stow <package_name>
```

However, some configurations may not run immediately. Make sure you have the
dependencies installed.

## Management

This dotfile repository is managed with [GNU stow](https://www.gnu.org/software/stow/).
Stow is a symlink manager which takes files or folders and links them to a
certain place. Per default stow links files and folders to the current parent
directory. Therefore, if this repository is cloned to the home directory the
configurations can be linked by

```sh
stow <folder_name>
# For example
stow bash
```

Make sure the files do not yet exist in your file system. In such cases stow
will throw an error.

## Configurations

An individual description to each configuration can be found inside the
corresponding folder.
