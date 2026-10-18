"""Import only MATLAB coursework; preserve local source hashes and timestamps.

Run from this repository after placing the supplied collection under the shared
workspace's Original Codes directory. Existing imported files are not replaced.
"""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import shutil

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT.parents[1] / 'Original Codes/Processamento de Sinal e Imagem/TP'


def main():
    records = []
    for source in sorted(SOURCE.rglob('*.m')):
        if 'Resolução' in source.parts or source.name.startswith(('AndreMarcal', 'load_nii', 'xform_nii')):
            continue
        relative = source.relative_to(SOURCE)
        target = ROOT / 'coursework' / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        if not target.exists():
            shutil.copy2(source, target)
        digest = hashlib.sha256(source.read_bytes()).hexdigest()
        if hashlib.sha256(target.read_bytes()).hexdigest() != digest:
            raise ValueError(f'Imported source differs: {relative}')
        records.append({'original_path': relative.as_posix(),
                        'repository_path': target.relative_to(ROOT).as_posix(),
                        'original_modified_utc': datetime.fromtimestamp(source.stat().st_mtime, timezone.utc).isoformat(),
                        'original_sha256': digest,
                        'attribution': 'preliminary course notes; individual authorship unspecified' if relative.parts[0] == 'TP0'
                                       else 'Jorge Barbosa Pereira, as identified in the supplied coursework'})
    (ROOT / 'docs/source-provenance.json').write_text(json.dumps(records, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(f'Imported {len(records)} MATLAB coursework files with matching SHA-256 hashes.')


if __name__ == '__main__':
    main()
