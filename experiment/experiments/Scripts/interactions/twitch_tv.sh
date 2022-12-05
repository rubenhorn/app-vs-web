#! /bin/bash

# precondition: twitch.tv is already opened in the browser
# postcondition: live stream is playing (24/7)

# Check device resolution
test "$(adb shell wm size | grep -oP "\d.*$")" == "1080x2340" || echo "Warning! Expected 1080x2340 device."

# Wait for any cookie pop-up to appear
sleep 3
# Accept cookies
# adb shell input tap 750 1585

# Go back just in case we did just open a video (no cookie pop-up)
# adb shell input tap 50 300

# Open search
adb shell input tap 900 300
sleep 1
# Look up 24/7 stream (animals)
adb shell input text "CritterVision"
adb shell input keyevent 66

# Open video
adb shell input tap 200 700
