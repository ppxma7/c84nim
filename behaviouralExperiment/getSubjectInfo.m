function [ hasConsented ] = getSubjectInfo(  )
%getSubjectInfo - Asks the subject for consent
%   Returns a structure that contains fields
%   Subject queried with a GUI to determine if he/she gives consent
%   Saves result in structure (consented)
%
%   see also: getExperimentParams, input, str2double, questdlg
%
%   ma - 2015-11-4  

% Create a data structure that holds info
data = struct('consented', logical.empty);

% Ask subject for info
temp = questdlg('Have you consented to take part in this study?', ...
    'Consent', 'Yes', 'No', 'No');
data.consented = strcmp(temp, 'Yes');
hasConsented = strcmp(temp, 'Yes');

end

