# Ethkuil's dotfiles

## Usage

```bash
./config.sh
```

It can work in both Windows and Linux.

`batch_relink.sh` is a universal script for both Windows and Linux to to batch relink the dotfiles. To create symbolic links, it uses `mklink` in Windows and `ln` in Linux.

`symlink.bat` is a Windows batch script to create symbolic links, supporting both directories and files.

> You may want to run `winget add gerardog.gsudo` to get `sudo` command in Windows. Because `mklink` requires administrator privilege.
