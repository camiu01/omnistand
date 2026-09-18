<div align="center">

# Omni-Stand
### Universal Parametric Console Stand

One stand for every handheld: PSP, Vita, Switch, Steam Deck, ROG Ally, phones and controllers. Fully parametric, 3D-printable.

[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-lightgrey.svg)](LICENSE)
[![OpenSCAD](https://img.shields.io/badge/OpenSCAD-2021.01+-informational.svg)](https://openscad.org/)
[![Python](https://img.shields.io/badge/Python-3.10+-yellow.svg)](https://www.python.org/)
[![Status](https://img.shields.io/badge/Status-Active-success.svg)](#)

</div>

---

## Overview

Omni-Stand is a universal desk stand for handheld consoles and mobile devices. A trapezoidal footprint with a front retaining lip and twin rear backrest pillars holds the device at a stable upright angle, while the fully parametric model adapts to anything from a slim phone to a wide Steam Deck.

No fixed slots, no device-specific molds: every width, height, pocket, and cable bore is a Customizer slider.

### Key Highlights

* **Truly Universal:** One model covers phones, handhelds, and controllers via parametric widths and bridge heights.
* **Stable Trapezoidal Footprint:** Wide rear stance with tapered front resists tipping on crowded desks.
* **Front Retaining Lip:** Raised lip with optional center pocket for charging cables and custom engraved label.
* **Twin Rear Pillars:** Tall backrest with auto-fit center pocket — light where possible, solid where needed.
* **Charge-While-Docked:** Rear, front, left, and right cable pass-throughs plus USB-C dock slot, strain-relief groove, under-base channel, and side clip.
* **YAPBPS Structure:** `main.scad` Customizer entry point, `modules/` includes, `build.py` single-file bundler, validation asserts with console warnings.

---

## Compatibility

Default dimensions fit a PSP 1000-style device. Adapt in seconds via the Customizer:

| Device | Width (mm) | Suggested Tuning |
| :--- | :--- | :--- |
| **Phone (6-7")** | 75 - 85 | Narrow `base_rear_width`, lower `backrest_total_height` to 60-70 |
| **PSP 1000 / Vita** | 75 - 85 | Defaults work, set `engraved_text_string` to taste |
| **Nintendo Switch / OLED** | 100 - 110 | Widen base to ~135, raise pocket bridge for Joy-Con clearance |
| **Steam Deck / ROG Ally / Legion Go** | 115 - 300 | Widen base to 150-180, raise `backrest_total_height` to 100-120, enlarge `cable_diameter` to 14-16 |
| **Controller / dock display** | 150+ | Disable `lip_pocket_enable`, widen `rear_pocket_width` manually |

Rule of thumb: base rear width should exceed device width by 30-50 mm; pillar depth must exceed cable diameter by at least 4 mm.

---

## Project Layout

```text
omni-stand/
+-- main.scad                    # Customizer parameters + render stage
+-- build.py                     # Bundler: inlines include <> into omni-stand_merged.scad
+-- omni-stand_merged.scad       # Generated single-file distribution (via python build.py)
+-- README.md / LICENSE / CONTRIBUTING.md / CODE_OF_CONDUCT.md / SECURITY.md
+-- modules/
    +-- core_logic.scad          # Derived dims, validation asserts, warnings
    +-- stand_body.scad          # Solid extrusion + cutout wiring (omni_stand)
    +-- cutouts/
        +-- cutouts.scad         # Cutouts aggregator
        +-- base/helpers.scad    # trapezoid_profile(), rounded_box_2d()
        +-- pockets.scad         # Floor cavity, lip pocket, rear pocket
        +-- cable_channels.scad  # Cable pass-throughs
        +-- charging.scad        # Dock plug slot, strain relief, under-base channel, clip
        +-- engraving.scad       # Front recessed text
```

Always open `main.scad` directly. Never launch modules from inside `modules/`.

---

## Quick Start

### Prerequisites

* [OpenSCAD](https://openscad.org/) (v2021.01 or later)
* [Python](https://www.python.org/) (v3.10+, required only for compiling single-file distributions)

### Workflow

1. **Open the project:**
```bash
openscad main.scad
```

2. **Pick your device:**
In OpenSCAD, open **Window** > **Customizer** and set base widths, backrest height, and pocket bridges from the table above.

3. **Route the cable:**
Enable the matching bore (`cable_rear_enable`, `cable_right_enable`, ...) and slide its `*_pos_percent` until the plug clears the pillars. For charge-while-docked, enable `dock_enable`, size `dock_plug_w/h` to your plug, and keep `dock_relief_enable` on so the cable bends without stress.

4. **Verify design:**
* Press `F5` for preview.
* Watch the console for warnings:
```text
ECHO: "WARNING: cable_diameter exceeds pillar_depth, rear bore may break walls."
```

5. **(Optional) Bundle into single file:**
```bash
python build.py
```

---

## Customizer Guide

| Section | What It Controls |
| :--- | :--- |
| **Render & Tolerances** | `print_tolerance`, `render_stand`, facet resolution `$fn`, preview color |
| **1. Base Dimensions** | Footprint width, depth, corner radius, floor thickness |
| **2. Front Lip & Text** | Lip thickness/height, engraved label string, size, depth |
| **3. Front Lip Pocket** | Optional center opening for cables or wide plugs |
| **4. Rear Backrest** | Pillar height, width, depth — the main device-size lever |
| **5. Rear Pocket** | Center cutout between pillars (`0` = auto-fit) |
| **6. Floor Cavity** | Material-saving cutout and its margins |
| **7-8. Cable Routing** | Master toggle, bore diameter, per-side enable + position |
| **9. Dock Charging** | USB-C plug slot, position, strain-relief groove |
| **10. Under-Base Channel** | Hidden cable path carved under the base |
| **11. Side Cable Clip** | Spring clip bore on left, right, or both walls |

---

## Manufacturing Guide

### STL Export

1. Set `render_stand = true`. Render (`F6`), then Export STL (`F7`) as `OmniStand.stl`.
2. For sharing a preset, run `python build.py` and distribute `omni-stand_merged.scad` with your Customizer values noted.

### Recommended Slicer Settings

* **Filament:** PETG, ABS, or ASA (better creep resistance than PLA under console weight; PLA is fine for light phones).
* **Wall Loops / Perimeters:** `4 - 5` (keeps cable bores and pillar edges solid).
* **Top/Bottom Layers:** `5+` for a flat, warp-free base.
* **Infill:** `20% – 25%` (Gyroid or Honeycomb).
* **Supports:** None on flat base; organic/tree only if cable bores bridge poorly.
* **Brim:** Optional 5 mm brim for tall-pillar presets (Steam Deck height).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Please run `python build.py` before opening a pull request so the merged distribution stays in sync.

## License

Distributed under the [Creative Commons Attribution-ShareAlike 4.0 (CC BY-SA 4.0)](LICENSE).
