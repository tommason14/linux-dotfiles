# dotfiles for linux 

- BSPWM used with sxhkd
- These dotfiles should be installed with `stow`
- To install x11 files, use `sudo stow x11 -t /`
- For drivers, `sudo stow startup -t /`
- All other files are to be stored in `$HOME`, so `stow <folder>` works when this
  repo is cloned into `$HOME` (`stow` places folders in the parent folder by
  default)
