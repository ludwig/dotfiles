# ~/.xinitrc - config file read by startx
#
# Here are few references:
#   http://paddymullen.com/2010/01/17/xmonad-on-ubuntu/
#   http://en.wikipedia.org/wiki/X_resources
#   https://wiki.archlinux.org/index.php/X_resources
#   http://www.emacswiki.org/emacs/MovingTheCtrlKey
#

# Load up resources into the X server
xrdb -merge ~/.Xresources

# Make CapsLock into a Ctrl key
setxkbmap -option ctrl:nocaps

# Set the wallpaper
if [ -f ~/Pictures/Wallpaper/current.jpg ]; then
    feh --bg-fill ~/Pictures/Wallpaper/current.jpg
fi

# Finally, run xmonad
exec xmonad
