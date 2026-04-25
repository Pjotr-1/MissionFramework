@echo off

if "%1"=="" (
    echo Usage: build_n_patch.bat MISSION_NAME
    echo Example: build_n_patch.bat BEIRUT-1
    exit /b 1
)

echo Building MissionFramework...
python tools\build_mission_framework.py

echo Patching mission %1...
python tools\patch_miz.py %1

echo DONE