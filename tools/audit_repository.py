"""Audit publication files, Markdown links and provenance without MATLAB."""
import hashlib
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[1]


def main():
    records = json.loads((ROOT / 'docs/source-provenance.json').read_text(encoding='utf-8'))
    for record in records:
        path = ROOT / record['repository_path']
        assert hashlib.sha256(path.read_bytes()).hexdigest() == record['original_sha256'], path
    raw = subprocess.check_output(['git', 'ls-files', '--cached', '--others', '--exclude-standard', '-z'], cwd=ROOT)
    files = {ROOT / name for name in raw.decode('utf-8').split('\0') if name}
    blocked = {'.pdf', '.docx', '.nii', '.mp3', '.avi', '.rar', '.fig', '.mat'}
    for path in files:
        assert path.suffix.lower() not in blocked, path
        assert path.stat().st_size < 5_000_000, path
        assert not path.name.startswith(('AndreMarcal', 'load_nii', 'xform_nii')), path
        if path.suffix == '.md':
            for target in re.findall(r'\]\(([^)]+)\)', path.read_text(encoding='utf-8')):
                if '://' not in target and not target.startswith('#'):
                    assert (path.parent / target.split('#',1)[0]).exists(), (path, target)
    print(f'Passed: {len(records)} preserved source hashes, {len(files)} publication files, Markdown links and asset exclusions.')


if __name__ == '__main__':
    main()
