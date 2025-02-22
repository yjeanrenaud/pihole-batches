@echo off
REM batch script for Win11 to turn on a remote pi.hole dns blocking function
REM needs powershell to parse json response
REM REQUIRES app password (you may find/set that at https://pi.hole/admin/settings/api > Expert > Configure app password. Your regular password would also work, but I won't reccomend using it)
REM see:
REM https://github.com/yjeanrenaud/pihole-batches/

echo Authenticating at pi.hole and retrieving SID...
curl -ks -X POST "https://pi.hole:443/api/auth" ^
     -H "accept: application/json" ^
     -H "content-type: application/json" ^
     -d "{\"password\":\"APP-PASSWD\"}" > auth.json

REM Use PowerShell to extract the "sid" field from the JSON response
for /f "delims=" %%i in ('powershell -NoProfile -Command "((Get-Content auth.json -Raw | ConvertFrom-Json).session.sid)"') do set sid=%%i
rem pause
echo SID retrieved: %sid%
echo.
REM now do stuff

echo Enabling DNS blocking at pi.hole...
curl -ks -X POST "https://pi.hole:443/api/dns/blocking" ^
     -H "accept: application/json" ^
     -H "sid: %sid%" ^
     -H "content-type: application/json" ^
     -d "{\"blocking\":true}"

echo.
REM Cleanup temporary file and session id
del auth.json
curl -ks -X DELETE "https://pi.hole:443/api/auth" ^
     -H "accept: application/json" ^
     -H "sid: %sid%" ^
     -H "content-type: application/json"
echo
