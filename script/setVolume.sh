arg=$1
[ $arg = "up"     ] &&  pamixer -i 10
[ $arg = "down"   ] &&  pamixer -d 10
[ $arg = "toggle" ] &&  pamixer -t
