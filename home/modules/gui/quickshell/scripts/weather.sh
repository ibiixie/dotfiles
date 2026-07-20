#!/bin/sh

curl "https://api.open-meteo.com/v1/forecast?latitude=58.5942&longitude=16.1826&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,wind_speed_10m,wind_direction_10m,wind_gusts_10m,snowfall,showers,rain,weather_code&timezone=auto&forecast_days=1" | jq '.current.temperature_2m'
