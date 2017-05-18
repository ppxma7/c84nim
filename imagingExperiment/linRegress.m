function [betas, pred, s, x] = linRegress (fname, x)
% linRegress - performed linear regression on a given fMRI timecourse
%
%
%
%
% ma - 2015-12-2

if nargin < 2;
    fname = 'timecourse';
    
end

load(fname);

trimmedTimecourse = timecourse(9:end); % get rid of first 8 frames
trimmedTs = t.s(9:end);
trimmedTvols = t.vols(9:end);

% Put the new 'trimmed' values back in a struct
trimmedT = struct('vols',trimmedTvols, 's', trimmedTs);

x = makeMyDesignMatrix(); % make the design matrix

s = trimmedTimecourse;

plot(trimmedTs, s)

% linear regression
% This will spit out 3 numbers from makeMyDesignMatrix, which if multiplied
% by our prediction, will give us the best fit to the data
betas = x\s;
view(90,90) % perspective!

pred = x*betas; % matrix multiply the design matrix by the beta weights (n.b. y = x*betas + error)

figure
subplot(3,3, [1 2 3 4 5 6])
plot(s)
hold on
plot(pred, 'r')
xlabel('Time(s)')
ylabel('fMRI response')

subplot(3,3, [7 8 9])
plot(pred - s) % This is the error
xlabel('Time(s)')
ylabel('Residuals')

% Now get some stats

returnStats(betas, pred, s, x)

end