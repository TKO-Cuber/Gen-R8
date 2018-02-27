@echo off
title Gen-r8
color 0a
		
echo.		
echo.	
echo.	
echo                Welcome to Gen-r8! The all-in-one tool for generating custom firmwares.
echo.
echo.
echo                             ^_______ _________          ______   _______ 
echo                            ^(  ____ \\__   __/|\     /|/ ___  \ (  ____ )
echo                            ^| (    \/   ) (   | )   ( |\/   \  \| (    )|
echo                            ^| (__       | |   | (___) |   ___) /| (____)|
echo                            ^|  __)      | |   |  ___  |  (___ ( |     __)
echo                            ^| (         | |   | (   ) |      ) \| (\ (   
echo                            ^| (____/\   | |   | )   ( |/\___/  /| ) \ \__
echo                            ^(_______/   )_(   |/     \|\______/ |/   \__/
echo                                               Pre-Alpha 
echo                                             Version 0.0.1
echo.
echo.
echo.
echo.
echo                                          Eth3r by TKO_Cuber
echo                                           GUI by NX_Master
echo.
echo.
echo.
echo                                        If you haven't already, 
echo                              add your IPSW to the "PUT-IPSW-HERE" folder.
echo.
echo.
echo.
echo.
echo.
pause

	:: Just 'cuz you aren't a true hacker until everything is in lime green
	
	:: Time to define dem heckin' variables
	:: These will be needed for later maybe
	Set RootFS_Name=048-2484-005.dmg
	Set RestoreRamdisk_Name=048-2506-005.dmg
	Set RootFS_Key=4bcdd29f167775f32fd7c6bfec2e1f2ffec9b8d7bf72832092a8be71501e347c459e9bc5
	Set Ramdisk_IV=cea6367cd0819c15d6065295271f28d0
	Set Ramdisk_Key=ec1b68ffc225d13e0887adb96448e35d02462852514da00205c982d38a523575
	Set iBEC_Name=iBEC.n88ap.RELEASE.dfu
	Set iBEC_Location=Firmware/dfu/iBEC.n88ap.RELEASE.dfu
	Set iBEC_IV=dbe2d9627bec33a227bde550517ebdec
	Set iBEC_Key=cd9c4aeb0341d648833483f7aab1f69a06652e75d621651a758cb3a701f06c1b
	Set iBSS_Name=iBSS.n88ap.RELEASE.dfu
	Set iBSS_Location=Firmware/dfu/iBSS.n88ap.RELEASE.dfu
	Set iBSS_IV=539ae1e76ec0630ced66d091aa076b22
	Set iBSS_Key=1828ec8910a254a1b42c9442ac9f75afdd66026f77c9f8bbec51132b8c7a2f85
	Set iBoot_Name=iBoot.n88ap.RELEASE.img3
	Set iBoot_Location=Firmware/all_flash/all_flash.n88ap.production/iBoot.n88ap.RELEASE.img3
	Set iBoot_IV=8584d75b8816c9f5f93d1645e96ab0a5
	Set iBoot_Key=a42bda3cd80e18f2fb482f323c3b35584cc18a46dee455f9b8d1bd2333aca5de
	Set LLB_Name=LLB.n88ap.RELEASE.img3
	Set LLB_Location=Firmware/all_flash/all_flash.n88ap.production/LLB.n88ap.RELEASE.img3
	Set LLB_IV=f84f96844aeacc9a9269ae27c1e2bee8
	Set LLB_Key=2d6825153e7cde721046c7511139d9fe436e76341550b8ff8bbf9a41d38dd535
	Set Kernelcache_Name=kernelcache.release.n88
	Set Kernelcache_IV=38db66d2c332ed330944bfb2d894fd45
	Set Kernelcache_Key=c28b88a6f7821bfa6d40cb0a23444ede17e446310f034cbba5e9b211c19e9e0d
	Set fstab_Name=fstab
		:: ...Did I really just do that?
	Set fstab_Location=/private/etc/fstab
	Set Services_Location=System/Library/Lockdown/Services.plist
	Set asr_Location=/usr/sbin/asr
	Set options_Location=/usr/local/share/restore/options.plist
	Set N88AP_Location=/System/Library/CoreServices/SpringBoard.app/N88AP.plist
	Set General_Location=/Applications/Preferences.app/General.plist
	Set launchd_Location=/sbin/launchd
	Set lockdownd_Location=/usr/libexec/lockdownd
		:: Well that's a crap ton of variables if I've ever seen one!

		
		:: Main Program Time
  cd PUT-IPSW-HERE
  CLS
  ::ECHO Would you like verbose boot?
    ::SET INPUT=
      ::SET /P INPUT=Type "yes" or "no" ^>^>^>^>
        ::IF /I '%INPUT%'=='yes' GOTO yes
        ::IF /I '%INPUT%'=='no' GOTO no
		::IF /I '%INPUT%'=='wen' GOTO wtf
    ::CLS
  ::yes
    ::@echo yes my d00d> "PUT-IPSW-HERE/Special_Options/can_i_has_verbose_pls.txt"
	::GOTO KILL_ME
  ::no
    ::GOTO KILL_ME
  ::yes_bypass
    ::@echo please don't abuse this> "PUT-IPSW-HERE/Special_Options/pls_no_lock.txt"
	::GOTO DA_REAL_STUFF
  ::no_bypass
    ::GOTO DA_REAL_STUFF
  ::wtf
    ::cls
	::echo.
	::echo.
	::echo.
    ::echo eta son
	::echo.
	::echo.
	::echo.
	::echo.
	::echo.
	::pause
	::exit

  ::KILL_ME
    ::goto DA_REAL_STUFF  
    ::CLS
    ::ECHO **FOR TESTING PURPOSES ONLY**... delete setup.app?
      ::SET INPUT=
        ::SET /P INPUT=Type "yes" or "no" ^>^>^>^>
	      ::IF /I '%INPUT%'=='yes' GOTO yes_bypass
		  ::IF /I '%INPUT%'=='no' GOTO no_bypass
	
	
	
:: USE THE FOLLOWING  TO TELL IF THEY WANT VERBOSE BOOT OR NOT... IF NOT, GOTO THE NEXT INSTRUCTION. IF YES, IBOOT32PATCHER TO PASS -v BOOT ARG TO KERNEL 
::
:: 
:: IF EXIST "can_i_has_verbose_pls" (
::     (Command)
:: ) ELSE (
::     GOTO (Next instruction)
:: )



:DA_REAL_STUFF
CLS
echo Extracting IPSW
  7za.exe  x -oIPSW "iPhone2,1_6.1.3_10B329_Restore.ipsw" >NUL

echo Decrypting RootFS
  cd IPSW
  rename "048-2484-005.dmg" "rootfs.dmg"
  cd ..
  dmg extract "IPSW/rootfs.dmg" "IPSW/decrypted_rootfs.dmg" -k 4bcdd29f167775f32fd7c6bfec2e1f2ffec9b8d7bf72832092a8be71501e347c459e9bc5 >NUL
 
echo Adding room to RootFS
  hfsplus "IPSW/decrypted_rootfs.dmg" grow 1920783616 >NUL
  
::This is probably what breaks the jailbreak...
::echo Patching fstab
  ::hfsplus "IPSW/decrypted_rootfs.dmg" extract /private/etc/fstab fstab_original
  ::bspatch "fstab_original" "fstab" fstab.patch
  ::hfsplus "IPSW/decrypted_rootfs.dmg" rm /private/etc/fstab
  ::hfsplus "IPSW/decrypted_rootfs.dmg" add fstab /private/etc/fstab
  
::Probably don't need this...
  ::echo doing this as a test...
  ::  hfsplus "IPSW/decrypted_rootfs.dmg" extract /System/Library/CoreServices/SpringBoard.app/N88AP.plist N88AP_original.plist
  ::  hfsplus "IPSW/decrypted_rootfs.dmg" extract /Applications/Preferences.app/General.plist General_original.plist
  
echo Adding Cydia
  hfsplus "IPSW/decrypted_rootfs.dmg" untar "Cydia.tar" "/" >NUL
  
echo Jailbreaking
  hfsplus "IPSW/decrypted_rootfs.dmg" untar "p0sixspwn.tar" "/" >NUL
  

  ::echo Getting rid of setup.app
	::hfsplus "IPSW/decrypted_rootfs.dmg" rm "Applications/Setup.app/Setup"


:next
echo Rebuilding RootFS
  dmg build "IPSW/decrypted_rootfs.dmg" "IPSW/048-2484-005.dmg" >NUL

echo.
echo.
echo On to the Ramdisk...
echo.
echo.

echo Moving files...
cd IPSW
del 048-2506-005.dmg
cd ..
copy 048-2506-005.dmg "IPSW" >NUL
  
::echo Decrypting Ramdisk
  ::cd IPSW
  ::copy 048-2506-005.dmg ramdisk.dmg
  ::rename 048-2506-005.dmg 048-2506-005_original.dmg
  ::cd ..
  ::xpwntool "IPSW/ramdisk.dmg" "IPSW/decrypted_ramdisk.dmg" -iv cea6367cd0819c15d6065295271f28d0 -k ec1b68ffc225d13e0887adb96448e35d02462852514da00205c982d38a523575
 
::echo Adding space to Ramdisk
  ::hfsplus "IPSW/decrypted_ramdisk.dmg" grow 19461828 >NUL

echo Patching iBSS
  cd "IPSW/Firmware/dfu"
  del iBSS.n88ap.RELEASE.dfu
  cd ../../..
  copy iBSS.n88ap.RELEASE.dfu "IPSW/Firmware/dfu" >NUL
  ::xpwntool "IPSW/Firmware/dfu/iBSS_ORIGINAL.n88ap.RELEASE.dfu" "IPSW/Firmware/dfu/iBSS_DECRYPTED.n88ap.RELEASE.dfu" -iv 539ae1e76ec0630ced66d091aa076b22 -k 1828ec8910a254a1b42c9442ac9f75afdd66026f77c9f8bbec51132b8c7a2f85
  ::bspatch "IPSW/Firmware/dfu/iBSS_DECRYPTED.n88ap.RELEASE.dfu" "IPSW/Firmware/dfu/iBSS_PWNED.n88ap.RELEASE.dfu" ibss.patch
  ::xpwntool "IPSW/Firmware/dfu/iBSS_PWNED.n88ap.RELEASE.dfu" "IPSW/Firmware/dfu/iBSS.n88ap.RELEASE.dfu" -t "IPSW/Firmware/dfu/iBSS_ORIGINAL.n88ap.RELEASE.dfu"
  
echo Patching iBEC
  cd "IPSW/Firmware/dfu"
  del iBEC.n88ap.RELEASE.dfu
  cd ../../..
  copy iBEC.n88ap.RELEASE.dfu "IPSW/Firmware/dfu" >NUL
  ::xpwntool "IPSW/Firmware/dfu/iBEC_ORIGINAL.n88ap.RELEASE.dfu" "IPSW/Firmware/dfu/iBEC_DECRYPTED.n88ap.RELEASE.dfu" -iv dbe2d9627bec33a227bde550517ebdec -k cd9c4aeb0341d648833483f7aab1f69a06652e75d621651a758cb3a701f06c1b
  ::bspatch "IPSW/Firmware/dfu/iBEC_DECRYPTED.n88ap.RELEASE.dfu" "IPSW/Firmware/dfu/iBEC_PWNED.n88ap.RELEASE.dfu" ibec.patch
  ::xpwntool "IPSW/Firmware/dfu/iBEC_PWNED.n88ap.RELEASE.dfu" "IPSW/Firmware/dfu/iBEC.n88ap.RELEASE.dfu" -t "IPSW/Firmware/dfu/iBEC_ORIGINAL.n88ap.RELEASE.dfu"

 echo Patching iBoot
  cd "IPSW/Firmware/all_flash/all_flash.n88ap.production"
  del iBoot.n88ap.RELEASE.img3
  cd ../../../..
  copy iBoot.n88ap.RELEASE.img3 "IPSW/Firmware/all_flash/all_flash.n88ap.production" >NUL
  ::xpwntool "IPSW/Firmware/all_flash/all_flash.n88ap.production/iBoot_ORIGINAL.n88ap.RELEASE.img3" "IPSW/Firmware/all_flash/all_flash.n88ap.production/iBoot_dec.n88ap.RELEASE.img3" -iv 8584d75b8816c9f5f93d1645e96ab0a5 -k a42bda3cd80e18f2fb482f323c3b35584cc18a46dee455f9b8d1bd2333aca5de
  ::bspatch "IPSW/Firmware/all_flash/all_flash.n88ap.production/iBoot_dec.n88ap.RELEASE.img3" "IPSW/Firmware/all_flash/all_flash.n88ap.production/iBoot_PWNED.n88ap.RELEASE.img3" iboot.patch
  ::IF EXIST "Special_Options/can_i_has_verbose_pls.txt" (
    ::echo Adding sexy verbose boot
    ::iboot32patcher "IPSW/Firmware/all_flash/all_flash.n88ap.production/iBoot_dec.n88ap.RELEASE.img3" "IPSW/Firmware/all_flash/all_flash.n88ap.production/iBoot_VERBOSE.n88ap.RELEASE.img3" -b "-v"
	::pause
  ::) ELSE (
      ::GOTO more_ramdisk
  ::)
  ::pause
  
  ::more_ramdisk
  ::xpwntool "IPSW/Firmware/all_flash/all_flash.n88ap.production/iBoot_VERBOSE.n88ap.RELEASE.img3" "IPSW/Firmware/all_flash/all_flash.n88ap.production/iBoot.n88ap.RELEASE.img3" -t "IPSW/Firmware/all_flash/all_flash.n88ap.production/iBoot_ORIGINAL.n88ap.RELEASE.img3"
  ::pause

echo Patching LLB
  cd "IPSW/Firmware/all_flash/all_flash.n88ap.production"
  del LLB.n88ap.RELEASE.img3
  cd ../../../..
  copy LLB.n88ap.RELEASE.img3 "IPSW/Firmware/all_flash/all_flash.n88ap.production" >NUL

::echo Patching ASR
  ::hfsplus "IPSW/decrypted_ramdisk.dmg" rm /usr/sbin/asr
  ::hfsplus "IPSW/decrypted_ramdisk.dmg" add "asr" "/usr/sbin/asr"
  ::hfsplus "IPSW/decrypted_ramdisk.dmg" chmod "usr/sbin/asr" 100755
  
::echo fixing up options.plist
  ::hfsplus "IPSW/decrypted_ramdisk.dmg" rm /usr/local/share/restore/options.n88.plist
  ::hfsplus "IPSW/decrypted_ramdisk.dmg" add options.plist /usr/local/share/restore/options.plist
  ::hfsplus "IPSW/decrypted_ramdisk.dmg" add options.n88.plist /usr/local/share/restore/options.n88.plist
  
::echo Re-encrypting Ramdisk
  ::xpwntool "IPSW/ramdisk.dmg" "IPSW/048-2506-005.dmg" -t "IPSW/048-2506-005_original.dmg"

  ::Maid Mode: ACTIVATE!
echo Deleting unrequired files
  cd Special_Options
    ::del can_i_has_verbose_pls >NUL
  cd ..
  cd IPSW
    ::del decrypted_ramdisk.dmg >NUL
    del decrypted_rootfs.dmg >NUL
    del BuildManifest.plist >NUL
    del rootfs.dmg >NUL
    del 048-2730-005.dmg >NUL
    ::del 048-2506-005_original.dmg >NUL
    ::del ramdisk.dmg >NUL
   cd Firmware/dfu
    ::del iBEC_DECRYPTED.n88ap.RELEASE.dfu >NUL
	::del iBEC_ORIGINAL.n88ap.RELEASE.dfu >NUL
	::del iBEC_PWNED.n88ap.RELEASE.dfu >NUL
	::del iBSS_DECRYPTED.n88ap.RELEASE.dfu >NUL
	::del iBSS_ORIGINAL.n88ap.RELEASE.dfu >NUL
	::del iBSS_PWNED.n88ap.RELEASE.dfu >NUL
   cd ../..
   cd Firmware/all_flash/all_flash.n88ap.production >NUL
	::del iBoot_DECRYPTED.n88ap.RELEASE.img3 >NUL
	::del iBoot_ORIGINAL.n88ap.RELEASE.img3 >NUL
	::del iBoot_PWNED.n88ap.RELEASE.img3 >NUL
	::del LLB_DECRYPTED.n88ap.RELEASE.img3 >NUL
	::del LLB_ORIGINAL.n88ap.RELEASE.img3 >NUL
	::del LLB_PWNED.n88ap.RELEASE.img3 >NUL
   cd ../../../..
  ::Maid Mode: Deactivate!

  ::Pack dem files up and we're good to go!
echo Packing up the IPSW
  COPY 7z.exe "IPSW/7z.exe" >NUL
  cd IPSW
  7z u -tzip -mx0 Gen_R8.ipsw -x!7z.exe  >NUL
  echo Moving IPSW
  copy Gen_R8.ipsw "../../"  >NUL
  cd ..
  
echo.
echo.
echo.
echo.
echo             Your IPSW has been generated.
echo.
echo           You will need iTunes 11.0.5 to restore
echo.
echo.
echo                   Gen-r8 by TKO_Cuber
echo.
pause

::Cue the final song... close the curtains... we did it bois!
  ::The audience stands and applauds. 
  ::Claps roar through the room.
  ::The show is finally over.
  :: ~~End
  
  

