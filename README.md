MissionFramework

MissionFramework is a modular Lua framework for DCS World mission scripting, designed for:
Dynamic gameplay systems (fog, AI, spawn, difficulty)
Clean architecture with multiple modules
Compatibility with MOOSE and native DCS scripting
Fast iteration using external build + patch workflow

🚀 Features
Modular Lua architecture (core, rng, config, managers, etc.)
Deterministic RNG (sandbox-safe)
Dynamic fog system (runtime interpolation)
External build system (no Mission Editor reload required)
.miz auto-patching workflow

📁 Project Structure
MissionFramework/
  src/        # Lua source files
  dist/       # Generated bundle (mission_framework.lua)
  tools/      # Build and patch scripts
  test/       # DCS mock environment
  docs/       # Generated documentation
  
  🧭 Architecture
           +----------------------+
           |   MissionFramework   |
           +----------------------+
                     |
    ---------------------------------------
    |        |        |         |         |
  Core     RNG     Config   Logger   Managers
                                      |
                           ---------------------
                           |        |         |
                        FogMgr   SpawnMgr   AI/Logic

🛠️ Build
Generate the combined Lua file:
python tools/build_mission_framework.py
Output:
dist/mission_framework.lua

🧩 Patch Mission (.miz)
Patch the generated script into your mission:
python tools/patch_miz.py BEIRUT-1
You can also use:
python tools/patch_miz.py BEIRUT-1.miz
python tools/patch_miz.py "C:\full\path\mission.miz"

⚠️ First-Time Setup
Open your mission in Mission Editor
Add trigger:
MISSION START → DO SCRIPT FILE → mission_framework.lua
Save the mission
This creates:
l10n/DEFAULT/mission_framework.lua
After that, patching works automatically.
🎮 Workflow
1. Edit Lua files (src/)
2. Build:
   python tools/build_mission_framework.py
3. Patch:
   python tools/patch_miz.py BEIRUT-1
4. Restart mission in DCS

🧪 Local Testing
Run outside DCS:
lua dist/mission_framework.lua
Uses:
test/dcs_mock.lua
Simulates:
timer
world.weather
env logging

🤝 MOOSE Compatibility
Load order:
1. Moose.lua
2. mission_framework.lua
MissionFramework does not include MOOSE.

📚 API Documentation (Auto-Generated)
This project supports automatic documentation via LDoc.
Install LDoc
luarocks install ldoc
Generate documentation
ldoc src
Output:
doc/
Optional config (config.ld)
Create file:
project = "MissionFramework"
title = "MissionFramework Documentation"
format = "markdown"
dir = "docs"
file = {"src"}
Then run:
ldoc .

🧠 Design Principles
Single global namespace (MissionFramework)
No sandbox violations (os, lfs, etc.)
Deterministic RNG
Fail-fast configuration
Modular, scalable architecture

📌 Roadmap
SpawnManager
TargetManager
DifficultyManager
NavigationManager
ROE system
AI coordination (buddy lasing, CAS)

📜 License
MIT License

👤 Author
Per
DCS simulation, systems design, and mission architecture


[![Version](https://img.shields.io/github/v/tag/@Pjotr-1/MissionFramework?label=version)](https://github.com/@Pjotr-1/MissionFramework/tags)
[![License](https://img.shields.io/github/license/@Pjotr-1/MissionFramework)](LICENSE)
[![Docs](https://github.com/@Pjotr-1/MissionFramework/actions/workflows/docs.yml/badge.svg)](https://github.com/@Pjotr-1/MissionFramework/actions/workflows/docs.yml)
[![Release](https://github.com/@Pjotr-1/MissionFramework/actions/workflows/release.yml/badge.svg)](https://github.com/@Pjotr-1/MissionFramework/actions/workflows/release.yml)
