# pihole-scripts
batch and bash scripts to turn on and off remote pi-hole DNS blocking function
I find it usefull to use the cli to use the [pihole](https://github.com/pi-hole/pi-hole) api, e.g. when using it with [homebridge](https://github.com/homebridge/homebridge). Like that, I can tell siri to turn on the ads when one needs to access a specific service in my network that is usually blocked by pihole-FTL.
## requirements
- install and configure [pi-hole](https://pi-hole.net/)
- ##set up an app password: https://pi.hole/admin/settings/api
![grafik](https://github.com/user-attachments/assets/617979f0-269b-47ea-9b09-be9df514209f)
- (you also could use your regular dashboard/api password, but I would not reccomend it as it is stored as plain text in the scripts
- under *nix systems, the scripts require jq: `sudo apt update; sudo apt install jq`
- Windows systems need PowerShell installed (as per default on Win10 and Win11)
## usage
- use `turnoff-pihole` to turn the pi.hole off for 30 seconds
- use `turnon-pihole` to turn the pi.hole on
