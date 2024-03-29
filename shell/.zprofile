#
# /etc/zprofile and ~/.zprofile are run for login shells
#

_src_etc_profile()
{
    #  Make /etc/profile happier, and have possible ~/.zshenv options like
    # NOMATCH ignored.
    #
    emulate -L ksh

    # source profile
    if [ -f /etc/profile ]; then
	    source /etc/profile
    fi
}
_src_etc_profile

unset -f _src_etc_profile


if [ -f ~/.zshrc ]; then
    source ~/.zshrc
fi

[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx

