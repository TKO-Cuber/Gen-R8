
@echo off
title IPSW-GEN
echo Welcome to IPSW-GEN! The all-in-one tool for generating custom firmwares :)
pause
echo If you haven't already, add your IPSW to the "PUT-IPSW-HERE" folder. Yes it's crowded... don't worry.
pause

echo Extracting IPSW
  cd PUT-IPSW-HERE
  7z x -oIPSW "iPhone2,1_6.1.3_10B329_Restore.ipsw"
  cd ..
