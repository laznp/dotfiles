#!/usr/bin/env bash
# Small delay before suspending so the "Suspend PC" app's own streaming
# session/GPU teardown has time to settle first (avoids a GPU S3 race
# that can hang mid-suspend right after a stream just closed).
sleep 5
systemctl suspend
