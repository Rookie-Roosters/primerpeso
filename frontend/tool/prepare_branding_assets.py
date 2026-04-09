#!/usr/bin/env python3
"""Prepare branding image assets from a single source logo image."""

from __future__ import annotations

import colorsys
from collections import deque
from pathlib import Path

from PIL import Image


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "assets" / "branding" / "primerpeso_source.png"
ICON_OUT = ROOT / "assets" / "branding" / "icon_square.png"
SPLASH_OUT = ROOT / "assets" / "branding" / "splash_full_trimmed.png"


def _signal_profile(rgb: Image.Image) -> tuple[list[list[bool]], list[int], list[int]]:
    w, h = rgb.size
    pixels = rgb.load()
    mask = [[False for _ in range(w)] for _ in range(h)]
    row_counts = [0 for _ in range(h)]
    col_counts = [0 for _ in range(w)]

    for y in range(h):
        for x in range(w):
            pr, pg, pb = pixels[x, y]
            hr, hs, hv = colorsys.rgb_to_hsv(pr / 255.0, pg / 255.0, pb / 255.0)
            _ = hr
            # Keep saturated branding colors and dark glyph pixels, ignore neutral background.
            if (hs >= 0.14 and hv <= 0.985) or (hv <= 0.55):
                mask[y][x] = True
                row_counts[y] += 1
                col_counts[x] += 1
    return mask, row_counts, col_counts


def _component_boxes(mask: list[list[bool]]) -> list[tuple[int, int, int, int, int]]:
    """Return connected component tuples: (area, left, top, right, bottom)."""
    h = len(mask)
    w = len(mask[0]) if h > 0 else 0
    seen = [[False for _ in range(w)] for _ in range(h)]
    boxes: list[tuple[int, int, int, int, int]] = []

    for y in range(h):
        for x in range(w):
            if not mask[y][x] or seen[y][x]:
                continue
            q: deque[tuple[int, int]] = deque()
            q.append((x, y))
            seen[y][x] = True
            area = 0
            left = right = x
            top = bottom = y

            while q:
                cx, cy = q.popleft()
                area += 1
                left = min(left, cx)
                right = max(right, cx)
                top = min(top, cy)
                bottom = max(bottom, cy)

                for nx, ny in (
                    (cx - 1, cy),
                    (cx + 1, cy),
                    (cx, cy - 1),
                    (cx, cy + 1),
                ):
                    if 0 <= nx < w and 0 <= ny < h and mask[ny][nx] and not seen[ny][nx]:
                        seen[ny][nx] = True
                        q.append((nx, ny))

            boxes.append((area, left, top, right, bottom))

    return boxes


def _first_last_indexes(values: list[int], min_value: int) -> tuple[int, int]:
    first = next((i for i, value in enumerate(values) if value >= min_value), 0)
    last = next(
        (i for i in range(len(values) - 1, -1, -1) if values[i] >= min_value),
        len(values) - 1,
    )
    return first, last


def _expand_box(
    left: int, top: int, right: int, bottom: int, margin: int, max_w: int, max_h: int
) -> tuple[int, int, int, int]:
    left = max(0, left - margin)
    top = max(0, top - margin)
    right = min(max_w - 1, right + margin)
    bottom = min(max_h - 1, bottom + margin)
    return left, top, right, bottom


def _square_from_box(
    left: int, top: int, right: int, bottom: int, max_w: int, max_h: int
) -> tuple[int, int, int, int]:
    box_w = right - left + 1
    box_h = bottom - top + 1
    side = max(box_w, box_h)
    cx = (left + right) / 2.0
    cy = (top + bottom) / 2.0
    sq_left = int(round(cx - side / 2.0))
    sq_top = int(round(cy - side / 2.0))
    sq_left = max(0, min(sq_left, max_w - side))
    sq_top = max(0, min(sq_top, max_h - side))
    return sq_left, sq_top, sq_left + side - 1, sq_top + side - 1


def main() -> None:
    if not SOURCE.exists():
        raise SystemExit(f"Missing source image: {SOURCE}")

    image = Image.open(SOURCE).convert("RGBA")
    rgb = image.convert("RGB")
    w, h = image.size

    mask, row_counts, col_counts = _signal_profile(rgb)

    row_min = max(2, int(w * 0.004))
    col_min = max(2, int(h * 0.004))
    full_top, full_bottom = _first_last_indexes(row_counts, row_min)
    full_left, full_right = _first_last_indexes(col_counts, col_min)
    full_left, full_top, full_right, full_bottom = _expand_box(
        full_left, full_top, full_right, full_bottom, margin=22, max_w=w, max_h=h
    )

    splash = image.crop((full_left, full_top, full_right + 1, full_bottom + 1))
    splash.save(SPLASH_OUT)

    components = _component_boxes(mask)
    top_half_components = [
        comp for comp in components if ((comp[2] + comp[4]) / 2.0) < (h * 0.62)
    ]
    chosen = max(top_half_components or components, key=lambda comp: comp[0])
    _, icon_left, icon_top, icon_right, icon_bottom = chosen
    icon_left, icon_top, icon_right, icon_bottom = _expand_box(
        icon_left, icon_top, icon_right, icon_bottom, margin=14, max_w=w, max_h=h
    )
    icon_left, icon_top, icon_right, icon_bottom = _square_from_box(
        icon_left, icon_top, icon_right, icon_bottom, max_w=w, max_h=h
    )

    icon = image.crop((icon_left, icon_top, icon_right + 1, icon_bottom + 1))
    icon.save(ICON_OUT)

    print(f"source: {SOURCE}")
    print(f"icon:   {ICON_OUT} ({icon.width}x{icon.height})")
    print(f"splash: {SPLASH_OUT} ({splash.width}x{splash.height})")


if __name__ == "__main__":
    main()
