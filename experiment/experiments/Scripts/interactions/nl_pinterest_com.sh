#! /bin/bash

# I guess it sort of works ^^

# precondition: pinterest.com is already opened in browser (NOT logged in)
# postcondition: Scrolled through and opened posts for 6 minutes

# Check device resolution
test "$(adb shell wm size | grep -oP "\d.*$")" == "1080x2340" || echo "Warning! Expected 1080x2340 device."


START=$(date +%s)

function interact()  {
    # Scroll down
    adb shell input swipe 500 2000 500 1000
    sleep 1
    adb shell input swipe 500 2000 500 1000
    sleep 1
    adb shell input swipe 500 2000 500 1000
    sleep 1
    # Open post
    adb shell input tap 300 1000
    sleep 1
    # Close ad for native pinterest app
    if [ "$1" == "first" ]
    then
        # ...then click on the close button (or open another post below the post)
        adb shell input tap 90 1700
    fi
    sleep 1
    adb shell input swipe 500 800 500 200
    sleep 1
    adb shell input swipe 500 800 500 200
    sleep 1
    adb shell input swipe 500 800 500 200
    sleep 1
    # Go back
    adb shell input keyevent 4
}

# Handle ad for native app
interact first
# Loop for 360 seconds (6 minutes)
while true
do
    # Main interaction loop (takes roughly 24 seconds)
    interact
done

exit

# Below: Interaction for login (not used)
# Log in
cd "$(dirname "$0")"
USER=$(cat credentials.csv | grep "^pinterest" | awk -F "," '{print $2}')
PASS=$(cat credentials.csv | grep "^pinterest" | awk -F "," '{print $3}')
adb shell input tap 700 1050
sleep 2
adb shell input tap 700 500
adb shell input text "$USER"
adb shell input keyevent 66
sleep 1
adb shell input tap 700 900
adb shell input text "$PASS"
adb shell input keyevent 66
sleep 1
# Accept cookies
adb shell input tap 700 1700
# Use web app
adb shell input tap 700 1400
sleep 3