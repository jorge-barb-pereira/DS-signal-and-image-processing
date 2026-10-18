# Original development dates and provenance

The supplied MATLAB source has last-modified timestamps spanning **19 February to 20 June 2021 (UTC)**. These dates document when the supplied files were modified; they do not prove exact project start dates or individual authorship. No historical Git repository accompanied the import, so commits are not backdated.

| Group | Documented source period |
| --- | --- |
| TP0 | February 2021 |
| TP1 | March 2021 |
| TP2 | March–April 2021 |
| TP3 | April 2021 |
| TP4 | May 2021 |
| TP5 | May 2021 |
| TP6 | June 2021 |

[source-provenance.json](source-provenance.json) records original paths relative to `TP`, corresponding repository paths, exact UTC modification times and original SHA-256 values. Files in `coursework` must match these hashes. TP0 notes are explicitly marked as unattributed preliminary exercises; the remaining files are identified by the student's supplied filenames and source headers.

The maintained library, demonstrations, tests and English documentation were prepared on **18 October 2026**. They have separate paths under `matlab`, `examples`, `tests` and `docs`, so later maintenance cannot be confused with the original submission.

## Included and excluded material

The technical import includes all non-instructor coursework `.m` files. Files under instructor-solution folders and those named `AndreMarcal_*` are excluded. Copied `load_nii*` and `xform_nii` utilities are third-party dependencies, not original portfolio work, and are excluded as well.

Image datasets, derived scan masks, NIfTI volumes, EEG/audio data, opaque filter objects, videos, figures, archives, assignment briefs and reports remain in the untouched local `Original Codes/Processamento de Sinal e Imagem` directory. The repository does not establish consent or redistribution rights for them. The source clarification about the two illumination algorithms is summarized in the review instead of republishing its original text file.
