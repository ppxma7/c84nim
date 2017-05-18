function [] = dataAnalysis (orientationByTrial, responseByTrial)
% dataAnalysis - This sorts the data into a useable format for least
%                   squares fitting to a sigmoid psychometric curve
%
%
% see also: lsqcurvefit, plot, sortData
% ma 2015-11-12

% Least squares fitting
%
% Run oriDiscrim, get two column vectors, orientationByTrial and
% responseByTrial
%
%combine into one file 'data'

%Puts in the right format..


data = sortData(orientationByTrial, responseByTrial);

save data;

% See how your initial data looks like
figure, plot(data(:,1), data(:,2), 'ro');

xdata = data(:,1);
ydata = data(:,2);

% Run lsqcurvefit
% Format: lsqcurvefit (fun, x0, xdata, ydata)

% Enter 2 values in the form [x, y], where x is the mean, and y is the SD,
% as a starting point for the algorithm
guess = input('Pick a mean and a SD: ');

x = lsqcurvefit(@myNormcdf, guess, xdata, ydata);

% Make a plot, run the curve fitting
times = linspace(xdata(1), xdata(end));
plot(xdata, ydata, 'ko', times, myNormcdf(x, times),'b-')
legend('Data', 'Fitted sigmoid')
xlabel('orientation')
ylabel('proportion of correct responses')


end