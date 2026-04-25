#!/bin/bash
wf-recorder --codec=h264_vaapi -f recording.mp4 -g "$(slurp)"
