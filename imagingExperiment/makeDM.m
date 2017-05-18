
function[d, hrf] = makeDM() % DELETE THIS LINE TO REVERT BACK
% makeDM - makes a design matrix
%        
%        - d/dRaw is the DM with/without HRF
%        - n is the no. repeats
%        - TR (s)
%
% ma 2015-12-14 see also: statsAssignment, returnStats, voxView

% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% ------------------------QUARANTINE---------------------------------------
% -------------------------------------------------------------------------
% function[d, dRaw, hrf] = makeDM(blockOne, blockTwo, n, TR, hrf)
% QUARANTINE....>
% load('sliceData.mat') 
% 
% if nargin == 0;
%     blockOne = info.blocksColumn1; 
%     blockTwo = info.blocksColumn2;
%     n = info.nBlocks;
%     TR = info.TR;
%     hrf = makeHrf(TR);
% end
% 
% % force column
% blockOne = blockOne(:);
% blockTwo = blockTwo(:);
% 
% % Stick them together & repeat n times
% theCat = cat(2, blockOne, blockTwo, ones(10, 1));
% dRaw = repmat(theCat, n, 1);
% 
% % Convolution
% dFace = conv(dRaw(:,1), hrf, 'same');
% dHouse = conv(dRaw(:,2), hrf, 'same');
% 
% dFace = dFace - mean(dFace);
% dHouse = dHouse - mean(dHouse);
% 
% d = [dFace, dHouse, dRaw(:,3)]; %reassign d
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% draw the DM

% This DM looks different to Denis'...
% I've tried deconvolving his, but our values for the hrf differ too
% Without seeing his raw blocks, I can't see where I've gone wrong.
% Adding this section to run his, as a backup....>
%
load('sliceData.mat');
load('designMatrix.csv');
d = designMatrix;
TR = info.TR;
hrf = makeHrf(TR);

% add a ramp
blockFour = linspace(-1,1,60);
blockFour = blockFour(:);
d = [d blockFour];
% change the title line to:  function[d, hrf] = makeDM()

dispMatrix(hrf,d);
end



 function [hrf] = makeHrf(TR)
% makeHrf - given the TR, return the HRF shape for t = 0 ... 30s
%
% ds originally, stolen by ma
 
tau = 2; % time constant (s) 
delta = 2; % time shift  (s)
t = [0:TR:30]; % vector of time points (in steps of TR)
tshift = max(t-delta,0); % shifted, but not < 0
hrf = (tshift ./ tau) .^2 .* exp(-tshift ./tau )./(2*tau); 
 
 end
 
 function [] = dispMatrix(hrf, d)
% dispMatrix - plots the design matrix 
%
%
% ma 2015-11-25


figure
subplot(3,3, [1 2 4 5 7 8])

imagesc(d, [-1, 1]);

colormap(gray);
colorbar

subplot(3,3, [3 6 9])
plot(hrf)
view(90, 90) % flips the perspective

end
 