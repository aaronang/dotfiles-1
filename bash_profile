#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# for nix
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi


