function [d, dRaw, hrf] = makeMyDesignMatrix(blockOne, n, TR, hrf)
% makeMyDesignMatrix - makes a design matrix
%
%                       - d/dRaw is the design matrix with/without HRF
%                       - blockOne - e.g. [1 1 1 0]
%                       - n - no. repeats
%                       - TR in sec
%                       - hrf - shape
%               e.g: blockOne  = [ones(1,4) zeros(1,12)]; 
%             [d, dRaw, hrf] = makeDesignMatrix(blockOne, 10)
%
%             figure
%             subplot(2,1,1), imagesc([ d, dRaw ]  )
%             subplot(2,1,2), plot(dRaw ,'k'), hold on, plot(d, 'r')
%
% ma 2015-11-25

if nargin <5; 
    blockOne = [zeros(1,10), ones(1,6)];
%     blockTwo = [ones(1,16)]; % this is just a vector of ones
    n = 10;
    TR = 1.5; % hardcoding is not advised, given time points, could use --> 
                            % diff(t.s([1 2]))
    hrf = makeHrf(TR);
elseif nargin == 2;
    TR = 1.5;
    hrf = makeHrf(TR);
end

% force to column vector using :
blockOne = blockOne(:);
% blockTwo = blockTwo(:);
blockTwo = [ones(1,16)]';

%concatenate
theCat = cat(2,blockOne, blockTwo);
% repmat to n
dRaw = repmat(theCat, n, 1);

% equally spaced 'ramp' from -1 to 1
blockThree = linspace(-1,1,numel(dRaw(:,1)));
blockThree = blockThree(:); % force column

% Convolve with hrf
d = conv(dRaw(:,1), hrf, 'same');

% now de-mean d
d = d - mean(d);

% turn d from 1 column to 3-column
d = [d,  blockThree, dRaw(:,2)]; %reassign d



% draw the design matrix
dispMatrix(hrf, d);



end

 function [hrf] = makeHrf(TR)
% makeHrf - given the TR, return the HRF shape for t = 0 ... 30s
%
% 
 
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
%
%
% ma 2015-11-25
% see makeMyDesignMatrix

figure
subplot(3,3, [1 2 4 5 7 8])
% imagesc([d, blockThree, dRaw(:,2)], [-1 1]); 
imagesc(d, [-1, 1]);

colormap(gray);
colorbar

% plot(d) , hold on
% plot(dRaw)
% view([90 90])

subplot(3,3, [3 6 9])
plot(hrf)
view(90, 90) % flips the perspective

% figure, imagesc(d');
% colormap(gray);



end
 
 