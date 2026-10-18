# Review and maintenance scope

This portfolio contains historical coursework and a separately maintained implementation of selected recurring algorithms. The original files in `coursework` are preserved byte-for-byte so the original submission can be distinguished from later repairs. Their inclusion is not a claim that they are production-ready or all execute with the available inputs.

| Original observation | Implication | Maintained treatment |
| --- | --- | --- |
| TP4 A3 repeats the same length-comparison condition in both padding loops | A longer second signal is not padded correctly; zero-energy references also divide by zero | `sipi.relative_error` handles either length ordering, row/column shapes and zero-reference policy |
| TP1 C stretches contrast by dividing by the original dynamic range | Constant images divide by zero | `sipi.contrast_stretch` returns zeros for constant images |
| TP1 A2/A3 validation uses an `elseif` chain after resizing N | Correcting N may bypass intensity checks | Maintained checkerboards validate all arguments independently and reject incompatible sizes |
| TP3/TP6 interpolation helpers do not reject coincident endpoints | Division by zero is possible | `sipi.linear_interpolate` requires a strictly increasing interval |
| TP6 D2 interpolation file declares the C2 function name | The filename and primary function name differ | Historical mismatch is documented; maintained interpolation uses a consistent API |
| TP4 C3 calls `raise` | This error path does not use MATLAB's normal `error` function | Historical code is not presented as fully repaired |
| Some illumination code computes `double(IM_O/255)` | Integer arithmetic may occur before conversion | Maintained functions convert to floating point before numerical transforms |
| Several scripts use hard-coded input paths, dimensions, sample rates or saved filter objects | Reproducibility depends on the original inputs and environment | New demos generate inputs and specify units/rates explicitly |
| FFT plots and filtering exercises use different normalizations | Frequency/normalization conventions need to be stated | Maintained spectrum documents its window, scale, DC and Nyquist behavior |
| Original exercises include multiple visual comparisons and manual measurements | Passing helper tests does not validate every figure or image result | CI exercises the maintained library and selected original helper domains only |

No clinical validity is inferred from the EEG/CT examples. The NIfTI loader and acquisition-specific volume offsets are external dependencies or dataset conventions; they are not generalized into a diagnostic implementation.

The maintained linear resampler is interpolation for learning purposes. It does not implement the anti-aliasing stage needed for general sample-rate reduction. The spectrum is a rectangular-window amplitude spectrum of a real signal, rather than a power spectral density estimate.

## Alternative illumination implementations

The author's TP1 clarification explains that A3 v1 was an iterative first approach, while v2 was the more efficient trigonometric version intended for assessment. The comparator examines their output differences; the author notes that the two images are slightly different despite achieving the intended effect. Both versions are preserved, without declaring them numerically equivalent. The maintained checkerboard function is a new 2026 implementation, not a replacement presented as original 2021 work.
