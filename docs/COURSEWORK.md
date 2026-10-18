# Coursework guide

Each TP folder preserves the supplied MATLAB filenames. Add the relevant folder to MATLAB's path rather than adding unrelated folders globally. Start from the repository root and use a writable output directory when an exercise saves files.

## TP0 — Introductory notes

Basic dice simulation and image type/display experiments. Individual authorship is unspecified in the supplied files, so these are labeled preliminary course notes. `cicle.m` includes a simulation up to 10^8 random draws and may require substantial memory; inspect its limits before running it.

## TP1 — Grayscale images and filtering

A1 constructs synthetic checkerboards; A2 adds a horizontal illumination ramp; A3 v1/v2 compare iterative and trigonometric directional illumination, with a separate comparison script. B–D explore contrast, negative images, gamma transforms, equalization and histogram specification. E/F compare mean and median filters under salt-and-pepper and Gaussian noise with different boundary padding.

Many functions accept a grayscale image path. Generate `output/demo/synthetic-gray.png` with `run_demo` and supply it explicitly where supported. Scripts that hard-code `Robot_BW.tif` still require local input configuration. Do not treat a replacement synthetic image as the original measured example.

## TP2 — Color and segmentation

A–C examine RGB/HSV representations and intensity equalization. D/E study spatial statistics, subdivisions and projections. F compares global thresholds; G/H study local segmentation under controlled illumination and compare segmentations with Jaccard scores. Helper files implement local thresholds and illumination transforms.

Use a synthetic RGB image for path-based examples, such as:

```matlab
addpath('coursework/TP2');
JorgePereira_TP2_A('output/demo/synthetic-rgb.png');
```

This is an exploratory historical function, not one of the numerically validated maintained APIs. Some subdivision routines and illumination helpers assume particular image sizes.

## TP3 — Objects, morphology and transformations

A1–A3 build binary masks, label components and study objects touching borders. B1/B2 explore erosion, dilation, opening and closing. C and D-series exercises address geometric transformations and visual comparisons, with interpolation/illumination helpers. Some exercises write animations or rely on particular photographs; the source remains available, but those inputs and videos are not redistributed.

## TP4 — Discrete signals and correlation

A-series studies complex exponentials, norms, energy and relative error. B-series compares noisy signals and moving-average filters, including delay compensation. C-series studies autocorrelation, cross-correlation, lag estimation and reference-pattern comparisons. These experiments mostly generate their own signals. The A3 error helper has known unequal-length/zero-reference limitations; use `sipi.relative_error` for the maintained behavior.

## TP5 — Fourier analysis and filtering

A1/A2 compare FFT properties and time-domain versus frequency-domain convolution. B-series explores spectra of noisy signals. C-series compares ideal and designed FIR/IIR filters using stored filter objects and signal-processing functions. The supplied `.mat` filter objects are excluded because they are opaque environment-dependent inputs; they must be recreated or supplied locally for historical scripts that load them. The maintained demo does not claim to reproduce those filter designs.

## TP6 — Sampling, interpolation and volumes

A/B use audio, instrument and EEG data. C-series examines interpolation and sample-rate changes. D-series loads NIfTI volumes, uses supplied masks and plots segmented slices/derived views. These historical scripts depend on local recordings, volume files, masks and an external `load_nii` implementation. None of those data are bundled here.

The maintained examples demonstrate interpolation on generated sequences, without implying the clinical validity of original volume experiments. The NIfTI helper files were third-party code and are identified in attribution rather than presented as the author's work.
