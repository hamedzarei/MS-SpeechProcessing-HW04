% Demonstrate DTW on a simple toy example
% DTW code to be downladed from Dan Ellis' website at Columbia
% http://labrosa.ee.columbia.edu/matlab/dtw/
clear
close all
clc

% path('..\..\voicebox',path);
addpath('E:\University\Digital_Speech_Recognition\sap-voicebox\voicebox');

%% Load utterances and compute MFCCs

[x1 fs1] = v_readwav('clean_digits/FCA_1A.wav'); 
[x2 fs2] = v_readwav('clean_digits/FCA_1B.wav'); 
[x3 fs3] = v_readwav('clean_digits/MAE_ZA.wav'); 

mfcc1 = melcepst(x1, fs1);
mfcc2 = melcepst(x2, fs2);
mfcc3 = melcepst(x3, fs3);

figure(1)
subplot(311); imagesc(mfcc1', [-3 6]); colorbar; title('ONE fast')
subplot(312); imagesc(mfcc2', [-3 6]); colorbar; title('ONE slow')
subplot(313); imagesc(mfcc3', [-3 6]); colorbar; title('SEVEN fast')


%% Align the fast and itself "ONES"
M = simmx(mfcc1',mfcc1');
[p, q] = dp(1-M);

figure(2)
subplot(131)
imagesc((1-M)');
colormap gray; colorbar; xlabel('source'); ylabel('target'); hold on
plot(round(p),round(q), 'LineWidth', 2)
drawnow

s = size(M);
M(s(1), s(2))
sum(M([p,q]))
sum(M([p,q]))/length(p)

%% Align the slow and fast "ONES"
M = simmx(mfcc1',mfcc2');
[p, q] = dp(1-M);

figure(2)
subplot(132)
imagesc((1-M)');
colormap gray; colorbar; xlabel('source'); ylabel('target'); hold on
plot(round(p),round(q), 'LineWidth', 2)
drawnow

figure (3)
subplot(221); imagesc(mfcc1(p,:)', [-3 6]); colorbar; title('ONE fast aligned')
subplot(223); imagesc(mfcc2(q,:)', [-3 6]); colorbar; title('ONE slow aligned')

s = size(M);
M(s(1), s(2))
sum(M([p,q]))
sum(M([p,q]))/length(p)

%% Align the slow "ONE" and "SEVEN"
M = simmx(mfcc1',mfcc3');
[p, q] = dp(1-M);

figure(2)
subplot(133)
imagesc((1-M)');
colormap gray; colorbar; xlabel('source'); ylabel('target'); hold on
plot(round(p),round(q), 'LineWidth', 2)
drawnow

s = size(M);
M(s(1), s(2))
sum(M([p,q]))
sum(M([p,q]))/length(p)

figure(3)
subplot(222); imagesc(mfcc1(p,:)', [-3 6]); colorbar; title('ONE fast aligned')
subplot(224); imagesc(mfcc3(q,:)', [-3 6]); colorbar; title('SEVEN fast aligned')
