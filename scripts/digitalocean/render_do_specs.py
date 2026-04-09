#!/usr/bin/env python3
"""Fill __PLACEHOLDER__ tokens in App Platform YAML from api.local.env / web.local.env."""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def load_env(path: Path) -> dict[str, str]:
    out: dict[str, str] = {}
    if not path.is_file():
        return out
    for line in path.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        k, _, v = line.partition("=")
        k = k.strip()
        v = v.strip().strip('"').strip("'")
        out[k] = v
    return out


def substitute(text: str, env: dict[str, str], path: Path) -> str:
    def repl(m: re.Match[str]) -> str:
        key = m.group(1)
        if key not in env or env[key] == "":
            print(f"Missing or empty env key for placeholder: {key}", file=sys.stderr)
            print(f"  Edit {path}", file=sys.stderr)
            sys.exit(1)
        return env[key]

    return re.sub(r"__([A-Z][A-Z0-9_]*)__", repl, text)


def main() -> None:
    if len(sys.argv) < 3:
        print("Usage: render_do_specs.py <api|web> <output.yaml>", file=sys.stderr)
        sys.exit(2)
    mode = sys.argv[1]
    out = Path(sys.argv[2])
    if mode == "api":
        env_path = ROOT / "scripts/digitalocean/api.local.env"
        spec_path = ROOT / ".do" / "app-api.yaml"
    elif mode == "web":
        env_path = ROOT / "scripts/digitalocean/web.local.env"
        spec_path = ROOT / ".do" / "app-web.yaml"
    else:
        print("mode must be api or web", file=sys.stderr)
        sys.exit(2)

    env = load_env(env_path)
    text = spec_path.read_text()
    text = substitute(text, env, env_path)
    if "__" in text and re.search(r"__[A-Z][A-Z0-9_]*__", text):
        left = set(re.findall(r"__[A-Z][A-Z0-9_]*__", text))
        print("Unresolved placeholders:", ", ".join(sorted(left)), file=sys.stderr)
        sys.exit(1)
    out.write_text(text)
    print(out)


if __name__ == "__main__":
    main()
