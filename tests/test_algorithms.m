function tests = test_algorithms
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
root = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(root,'matlab'));
addpath(fullfile(root,'coursework','TP3'));
addpath(fullfile(root,'coursework','TP4'));
addpath(fullfile(root,'coursework','TP6'));
testCase.TestData.root = root;
end

function testRelativeErrorUnequalLengths(testCase)
verifyEqual(testCase,sipi.relative_error([1,2],[1,2,3]),3/sqrt(5),'AbsTol',1e-12);
verifyEqual(testCase,sipi.relative_error([1,2,3],[1,2]),3/sqrt(14),'AbsTol',1e-12);
verifyEqual(testCase,sipi.relative_error([1;2],[1,2]),0);
end

function testRelativeErrorZeroReference(testCase)
verifyEqual(testCase,sipi.relative_error([0,0],[0,0]),0);
verifyError(testCase,@()sipi.relative_error([0,0],[1,0]),'sipi:ZeroReference');
end

function testInterpolationEndpointsAndMidpoint(testCase)
verifyEqual(testCase,sipi.linear_interpolate([0,0.5,1],0,1,10,20),[10,15,20]);
end

function testInterpolationRejectsInvalidIntervals(testCase)
verifyError(testCase,@()sipi.linear_interpolate(1,1,1,2,3),'sipi:InvalidInterval');
verifyError(testCase,@()sipi.linear_interpolate(2,0,1,2,3),'sipi:OutsideInterval');
end

function testCheckerboardShapeAndRange(testCase)
image = sipi.checkerboard_image(64,0.2,0.8,35);
verifySize(testCase,image,[64,64]);
verifyGreaterThanOrEqual(testCase,min(image(:)),0);
verifyLessThanOrEqual(testCase,max(image(:)),0.8+eps);
verifyEqual(testCase,numel(unique(image == 0)),2);
verifyError(testCase,@()sipi.checkerboard_image(65,0,1,0),'sipi:InvalidSize');
end

function testContrastConstantAndUint8(testCase)
verifyEqual(testCase,sipi.contrast_stretch(ones(4)),zeros(4));
verifyEqual(testCase,sipi.contrast_stretch(uint8([0,128;200,255])),double([0,128;200,255])/255);
end

function testGammaIdentityAndBrightening(testCase)
verifyEqual(testCase,sipi.gamma_transform([0,0.25;0.5,1],1),[0,0.25;0.5,1]);
verifyEqual(testCase,sipi.gamma_transform([0.25,1],0.5),[0.5,1],'AbsTol',1e-12);
end

function testSpectrumEvenOddAndDc(testCase)
for n = [1000,1001]
    fs = n;
    signal = 3 + 2*sin(2*pi*25*(0:n-1)/fs);
    [f,a] = sipi.amplitude_spectrum(signal,fs);
    verifyEqual(testCase,a(1),3,'AbsTol',1e-10);
    verifyEqual(testCase,a(f == 25),2,'AbsTol',1e-10);
end
end

function testSpectrumNyquistNotDoubled(testCase)
[~,a] = sipi.amplitude_spectrum((-1).^(0:99),100);
verifyEqual(testCase,a(end),1,'AbsTol',1e-12);
end

function testFftConvolutionMatchesDirect(testCase)
verifyEqual(testCase,sipi.fft_convolve([1,2,3],[4,5]),conv([1;2;3],[4;5]),'AbsTol',1e-12);
verifyEqual(testCase,sipi.fft_convolve([1+1i,2],[3,4i]),conv([1+1i;2],[3;4i]),'AbsTol',1e-12);
end

function testMedianRemovesIsolatedImpulse(testCase)
image = zeros(9); image(5,5) = 1;
[mean_image, median_image] = sipi.denoise_image(image,3);
verifyEqual(testCase,median_image,zeros(9));
verifyEqual(testCase,mean_image(5,5),1/9,'AbsTol',1e-12);
verifyError(testCase,@()sipi.denoise_image(image,2),'sipi:EvenWindow');
end

function testSegmentationSeparatesTwoLevels(testCase)
image = [zeros(8),ones(8)];
[mask,level] = sipi.segment_image(image);
verifyEqual(testCase,mask,logical(image));
verifyGreaterThanOrEqual(testCase,level,0);
verifyLessThanOrEqual(testCase,level,1);
end

function testLinearResamplingAndDomain(testCase)
[t,y] = sipi.resample_linear([0,10,20],2);
verifyEqual(testCase,t,[0;0.5;1;1.5;2]);
verifyEqual(testCase,y,[0;5;10;15;20]);
end

function testOriginalRelativeErrorAgainstReference(testCase)
% The submitted helper remains preserved; check its equal-length domain only.
value = JorgePereira_TP4_A3([1,2,3],[2,3,4]);
verifyEqual(testCase,value,sipi.relative_error([1,2,3],[2,3,4]),'AbsTol',1e-12);
end

function testOriginalInterpolationOnValidInterval(testCase)
value = JorgePereira_TP6_C2_Interpolacao(0.5,0,1,10,20);
verifyEqual(testCase,value,15,'AbsTol',1e-12);
end
