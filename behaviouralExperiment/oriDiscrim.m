function [ ] = oriDiscrim ()
%oriDiscrim - This runs the entire behavioural experiment
%             A line is presented, and asks the user whether it is leaning
%             to the left or the right.
%                              
% Inputs: nTrials, orientations
%
% Given a number of trials, and a vector [] of orientations (angles), the
% code will display a line at a random angle (within user definitions), and
% will wait for the participant to press '1' or '2', if the line is angled
% to the left or the right, respectively. 
%   
%
% see also: mglLines2, closeScreen, initialiseScreen, presentTrials,
% uniqueFilename, dataAnalysis, fileNameDefault
%
% ma - 2015-11-5
% ma - 2015-11-6 - added for loop, while loop, got it working...
% ma - 2015-11-6 - Overly optimistic, can't get the consent bit to run >:(
% ma - 2015-11-11 - Runs well, missing arg from getSubjectInfo sorted.
% ma - 2015-11-12 - Full experiment running, had to put filename at the
% end! >:((

validKeyCodes = mglCharToKeycode({'1', '2'});

% Put it all in a filename
% fileNameDefault
% filename = input('Enter the filename: ', 's');
% Enter an integer number
nTrials = input('Enter the number of trials: ');
% Enter a vector, e.g. [-10,10]
orientations = input('Enter the orientations to test: ');

initialiseScreen;

% % Consent
[hasConsented] = getSubjectInfo();
% deal with whether subject has consented right here
if hasConsented == false
  disp('(!) subject has not consented - exiting')
  % return from the main function...
  closeScreen
  return
end



% A welcome message to start the experiment:
mglTextSet('Helvetica', 20, [1 1 1], 0, 0, 0);
mglTextDraw('Welcome to the experiment',[0 1.0]);
mglTextDraw('1 = left, 2 = right',[0 0]);
mglTextDraw('Press any key to BEGIN',[0 -1.0])
mglFlush;
pause()
    % Wait for user input
mglClearScreen(0.5)

%numel gives the number of elements 
nOrientations = numel(orientations);

%randomise the orientations given, given the number of trials we want, and
%output it into a list 'trialOrder'
trialOrder = randi(nOrientations, 1, nTrials);

%column vector
orientations = orientations(:);


orientationByTrial = orientations(trialOrder);

%make space for saving responses
responseByTrial = nan(nTrials, 1);

%for loop

for iTrial = 1:nTrials
    
    %what is the orientation of this current trial (then we can save this
    %for the analysis with responses)
    currentOrientation = orientationByTrial(iTrial);
    
    % display stimuli from presentTrials
    r = presentTrials(currentOrientation, validKeyCodes);
    responseByTrial(iTrial) = r;
    
end

closeScreen

% save
% check for overwrites
fileName = uniqueFilename(fileNameDefault);
save(fileName, 'orientationByTrial', 'responseByTrial');

%Data analysis
dataAnalysis(orientationByTrial, responseByTrial);


end

