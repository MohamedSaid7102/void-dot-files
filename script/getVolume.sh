volume_info=$(amixer get Master | awk -F'[][]' '/%/ { print $2 }')
if [[ $volume_info == "off" ]]; then
  volume="X"
else
  volume="${volume_info}"
fi
echo "Vol: $volume"
