function [betas, pred, oneTimecourse, G, T1, T2, R2] = statsAssignment(fname)
% statsAssignment - performs voxel-wise linear regression on a given fMRI timecourse
%               
%               -fname is the file name containing the image
%
%               - Outputs: beta weights, model prediction, single voxel
%               timecourse, design matrix; which are fed into returnStats
%               
% ma 2015-12-14 see also: returnStats, makeDM, voxView

disp('==========================================================')
disp('==========================================================')
fprintf('\tPress the following buttons to display:\n')
fprintf('f\tmean fMRI slice\n')
fprintf('r\tr2 map\n')
fprintf('t\tt(1) map (faces v houses)\n')
fprintf('y\tt(2) map (house v faces)\n')
fprintf('q\tquit\n')
disp('                                                          ')
fprintf('\tNow sit back and wait for the MAGIC to happen...\n')
disp('==========================================================')
disp('==========================================================')

if nargin < 1; % Checking if the data is there
%     x = randi(length(array));
%     y = randi(length(array)); 
%     fname = 'sliceData.mat';
% elseif nargin == 2;
    fname = 'sliceData.mat';
end

load(fname);

G = makeDM(); % make the design matrix

% X axis won't change... 60 slices, TR = 3, so 180 seconds...
time = [1:info.TR:length(G)]; % x axis


% making some empty storage space
T1 = zeros(length(array), length(array), length(G));
T2 = zeros(length(array), length(array), length(G));
R2 = zeros(length(array), length(array), length(G));

tic;
% We need a for loop to iterate through each of the 128x128 2D slice,
% getting a timecourse for each voxel, and running stats on each one.

% If we wanted the entire picture, just set n and m = 1:length(array), but
% this will take too long, and cover an areas which is not brain.

for n = 36:95; % n = 36:95, and m = 25:85 gives a decent image.
    for m = 25:85;
        oneTimecourse = array(n,m,:);
        oneTimecourse = squeeze(oneTimecourse);
        betas = G\oneTimecourse;
        pred = G*betas;
        [t1, t2, r2] = returnStats(betas, pred, oneTimecourse, G);
        % save returnStats outputs into those empty arrays we made earlier
        T1(n,m) = t1;
        T2(n,m) = t2;
        R2(n,m) = r2;
    end
end

tt = toc; % Curious to see how long the loop takes... 
        % For the above numbers, takes about 52 seconds
disp(['Well, that''s ', num2str(tt), ' seconds you''ll never see again...'])       

% Get rid of 3rd dim
T1 = T1(:,:,1);
T2 = T2(:,:,1);
R2 = R2(:,:,1);

% Send them to voxView
voxView(T1, T2, R2);


end