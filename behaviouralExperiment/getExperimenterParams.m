function [ filename, nTrials, orientations ] = getExperimenterParams( )
%getExperimenterParams - Asks for the required input arguments
%   inputs: none
%   outputs: 
%           filename - a string e.g. 'test. mat'
%           nTrials - a number
%           orientations - vector, e.g. [-10:10]
%
%   Returns three variables, experimenter is required to determine values
%   for filename, nTrials, and angles.
%
%   ma - 2015-11-4


% Ask the experimenter for info
filename = input('Enter the filename: ', 's');

%use str2double to convert string --> number
nTrials = input('Enter the number of trials: ');
orientations = input('Enter the orientations to test: ');


end

