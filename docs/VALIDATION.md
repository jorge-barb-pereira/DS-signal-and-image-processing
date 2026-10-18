# Validation scope

MATLAB and GNU Octave were not found on the local Windows environment during preparation. Source hash checks and repository audits are run locally with the shared root Python environment. Those checks do not execute MATLAB code and are not reported as MATLAB test passes.

On **18 October 2026**, [GitHub Actions run 39120403772](https://github.com/jorge-barb-pereira/signal-and-image-processing/actions/runs/39120403772) completed successfully on Linux using MATLAB with Image Processing Toolbox and Signal Processing Toolbox. All **15 MATLAB test functions passed**, the 61 preserved source hashes passed the checkout audit, and `run_demo` generated five synthetic demonstration files. The two PNG outputs were retrieved and visually inspected before being added to the README. This is execution evidence from MATLAB, rather than a Python approximation of the algorithms.

The MATLAB GitHub Actions workflow provisions MATLAB, Image Processing Toolbox and Signal Processing Toolbox, then runs numerical regression tests and `run_demo`. It uploads synthetic demonstration artifacts on success. Public-project execution follows the [official setup action](https://github.com/matlab-actions/setup-matlab) and [command action](https://github.com/matlab-actions/run-command) documentation.

The 15 test functions cover relative error with unequal lengths and zero references, valid/invalid interpolation, checkerboard size/range, constant/integer image stretching, gamma transforms, even/odd FFT normalization, Nyquist amplitude, real/complex convolution, impulse denoising, two-level segmentation and linear resampling. Two tests compare selected original helpers on their valid domains.

These tests validate the maintained functions and limited historical helper behavior. They do not execute every coursework script, reconstruct original FIR/IIR designs, review the supplied medical/audio data or establish Octave compatibility. Historical scripts with unavailable data, saved objects or external loaders remain documented as requiring local setup.

```matlab
results = runtests('tests');
assertSuccess(results);
addpath('examples');
run_demo('output/demo');
```

The standalone Python publication audit can be run with `python tools/audit_repository.py`. The source reimport helper requires the untouched original local folder and is not required for ordinary use of the published repository.
