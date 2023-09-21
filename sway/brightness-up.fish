#!/usr/bin/env fish

set brightness (cat /sys/class/backlight/amdgpu_bl0/brightness)
set max_brightness (cat /sys/class/backlight/amdgpu_bl0/max_brightness)
set min_brightness 0

set step_percent 5

# Only supports whole numbers so have to round
set step (cat /sys/class/backlight/amdgpu_bl0/max_brightness)
set step (math --scale=0 "($max_brightness / 100) * $step_percent")

set brightness (math --scale=0 "$brightness + $step")

if test $brightness -lt $min_brightness
    set brightness $min_brightness
else if test $brightness -gt $max_brightness
    set brightness $max_brightness
end

echo $brightness | tee /sys/class/backlight/amdgpu_bl0/brightness
