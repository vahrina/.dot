@echo off
setlocal
set "CONF=%USERPROFILE%\.config\komorebi"

tasklist /fi "imagename eq komorebi.exe" | find /i "komorebi.exe" >nul && (
  komorebic stop
  exit /b
)

if not defined KOMOREBI_CONFIG_HOME (
    choice /m "set env var 'KOMOREBI_CONFIG_HOME' to '%CONF%'?"
    if errorlevel 2 goto END
    setx KOMOREBI_CONFIG_HOME "%CONF%" >nul
    set "KOMOREBI_CONFIG_HOME=%CONF%"
)

if not defined WHKD_CONFIG_HOME (
  setx WHKD_CONFIG_HOME "%CONF" >nul
  set "WHKD_CONFIG_HOME=%CONF%"
)

komorebic start --whkd -c "%KOMOREBI_CONFIG_HOME%\komorebi.json"
