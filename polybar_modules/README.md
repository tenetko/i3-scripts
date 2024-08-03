# Polybar modules


## The OpenWeatherMap module
- It uses this free API endpoint: [link](https://openweathermap.org/current).
- Get your free key here (you need to create an account): [link](https://home.openweathermap.org/api_keys).
- Icon glyphs have been chosen according to this table: [link](https://openweathermap.org/weather-conditions).
- You will need special fonts:
    - Material Design Icons ([link](https://github.com/Templarian/MaterialDesign-Webfont/tree/master/fonts));
    - Font Awesome ([link](https://fontawesome.com/download) or `sudo dnf install fontawesome-6-brands-fonts fontawesome-6-free-fonts`).
- You will have to specify these fonts in your `polybar/config.ini` config as follows:
```
[bar/mybar]
...
font-0 = Hack:style=Regular:size=12;2
font-1 = Material Design Icons:style=Regular:size=16;2
font-2 = Font Awesome 6 Free Solid:style=Regular:size=13;2
...
```
- Exact names for your fonts will be specified by the following command:
```
fc-list | grep -iE '(material|awesome)'
```
- The Bash script gets a string from the Python script and adds icons and color codes to it.


## The IqAir module
- It uses this free API endpoint: [link](https://api-docs.iqair.com/).
- Get your free key here (you need to create an account): [link](https://dashboard.iqair.com/personal/api-keys).
- You will have to refresh your key every year, it's free.
- You will need special fonts, as described in the previous paragraph. 
- The Bash script gets a string from the Python script and adds icons and color codes to it.


## The battery-combined-udev.sh module
- It checks current and max charges in the following files:
```
/sys/class/power_supply/BAT0/energy_now
/sys/class/power_supply/BAT0/energy_full
/sys/class/power_supply/BAT1/energy_now
/sys/class/power_supply/BAT1/energy_full
```
- Then it calculates the percentage and sets the icon according to the percentage.

