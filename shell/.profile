# resolution - fix retina display
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export GTK_SCALE=2
export GTK_DPI_SCALE=0.5
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# By default, camera is inverted - fix this with the lines below: https://askubuntu.com/questions/124929/how-can-i-horizontally-invert-the-video-output-of-the-webcam
export LIBV4LCONTROL_FLAGS=1 
export LD_PRELOAD=/usr/lib64/libv4l/v4l1compat.so
