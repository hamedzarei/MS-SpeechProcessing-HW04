function [ score ] = dtw_score( a, b )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[x1 fs] = v_readwav(a); 
[x2 fs] = v_readwav(b);

mfcc1 = melcepst(x1, fs);
mfcc2 = melcepst(x2, fs);

M = simmx(mfcc1',mfcc2');

s = size(M);
score = M(s(1), s(2));

end

