from pathlib import Path
import shutil
import sys
import tempfile
import zipfile

DEFAULT_MISSIONS_DIR = Path.home() / "Saved Games" / "DCS" / "Missions"
BUNDLE_PATH = Path("dist") / "mission_framework.lua"
MIZ_INTERNAL_PATH = "l10n/DEFAULT/mission_framework.lua"

def resolve_miz_path(arg: str) -> Path:
    path = Path(arg)

    if path.suffix.lower() != ".miz":
        path = path.with_suffix(".miz")

    if path.is_absolute():
        return path

    return DEFAULT_MISSIONS_DIR / path

def patch_miz(miz_path: Path) -> None:
    if not miz_path.exists():
        raise FileNotFoundError(f"Mission file not found: {miz_path}")

    if not BUNDLE_PATH.exists():
        raise FileNotFoundError(f"Bundle not found: {BUNDLE_PATH}")

    with tempfile.NamedTemporaryFile(delete=False, suffix=".miz") as tmp:
        tmp_path = Path(tmp.name)

    replaced = False

    with zipfile.ZipFile(miz_path, "r") as zin:
        with zipfile.ZipFile(tmp_path, "w", zipfile.ZIP_DEFLATED) as zout:
            for item in zin.infolist():
                if item.filename == MIZ_INTERNAL_PATH:
                    zout.writestr(item, BUNDLE_PATH.read_bytes())
                    replaced = True
                else:
                    zout.writestr(item, zin.read(item.filename))

    if not replaced:
        tmp_path.unlink()
        raise RuntimeError(
            f"Could not find {MIZ_INTERNAL_PATH} inside .miz. "
            "Load mission_framework.lua once in Mission Editor first."
        )

    shutil.move(str(tmp_path), str(miz_path))

    print(f"Patched {miz_path}")
    print(f"Updated {MIZ_INTERNAL_PATH}")

def main() -> None:
    if len(sys.argv) < 2:
        print("Usage:")
        print("  python patch_miz.py BEIRUT-1")
        print("  python patch_miz.py BEIRUT-1.miz")
        print(r'  python patch_miz.py "C:\full\path\mission.miz"')
        sys.exit(1)

    miz_path = resolve_miz_path(sys.argv[1])
    patch_miz(miz_path)

if __name__ == "__main__":
    main()