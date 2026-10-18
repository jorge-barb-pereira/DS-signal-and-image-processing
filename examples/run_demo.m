function run_demo(output_directory)
%RUN_DEMO Reproducible MATLAB examples using generated images and signals.
root = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(root,'matlab'));
if nargin < 1, output_directory = fullfile(root,'output','demo'); end
if ~exist(output_directory,'dir'), mkdir(output_directory); end
rng(42,'twister');
clean = sipi.checkerboard_image(256,0.2,0.95,30);
noisy = imnoise(clean,'salt & pepper',0.08);
[mean_image, median_image] = sipi.denoise_image(noisy,3);
[mask, ~] = sipi.segment_image(clean);
fig = figure('Visible','off','Position',[100,100,1100,650]);
subplot(2,3,1), imshow(clean), title('Synthetic illuminated board');
subplot(2,3,2), imshow(noisy), title('Salt-and-pepper noise');
subplot(2,3,3), imshow(median_image), title('Median filtering');
subplot(2,3,4), imshow(mean_image), title('Mean filtering');
subplot(2,3,5), imshow(sipi.gamma_transform(clean,0.5)), title('Gamma correction');
subplot(2,3,6), imshow(mask), title('Otsu segmentation');
exportgraphics(fig,fullfile(output_directory,'image-processing.png'),'Resolution',120);
close(fig);
fs = 100;
time = (0:999)'/fs;
signal = sin(2*pi*5*time) + 0.4*sin(2*pi*15*time);
[frequency, amplitude] = sipi.amplitude_spectrum(signal,fs);
fig = figure('Visible','off','Position',[100,100,1100,450]);
subplot(1,2,1), plot(time,signal), xlim([0,1]);
xlabel('Time (s)'), ylabel('Amplitude'), title('Synthetic two-tone signal');
subplot(1,2,2), plot(frequency,amplitude), xlim([0,25]);
xlabel('Frequency (Hz)'), ylabel('Amplitude'), title('One-sided amplitude spectrum');
exportgraphics(fig,fullfile(output_directory,'signal-processing.png'),'Resolution',120);
close(fig);
imwrite(clean,fullfile(output_directory,'synthetic-gray.png'));
rgb = cat(3,clean,fliplr(clean),flipud(clean));
imwrite(rgb,fullfile(output_directory,'synthetic-rgb.png'));
save(fullfile(output_directory,'synthetic-data.mat'),'clean','noisy','signal','time','fs');
fprintf('Synthetic demonstrations written to %s\n',output_directory);
end
