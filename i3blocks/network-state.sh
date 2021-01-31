GET_IP=$(ip addr show dev wlp0s20f3 | grep -oe '[0-9\.]\+/24' | awk -F '/' '{ print $1 }' | wc -l)
if [ "$GET_IP" != "1" ]; then
	echo "睊"
else
	echo "直"
fi
