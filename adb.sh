#!/bin/sh
adb kill-server
adb start-server
adb reverse tcp:19001 tcp:19001
adb reverse tcp:3449 tcp:3449
