function [ screenNumber ] = initialiseScreen( screenNumber, measurements )
%initialiseScreen -  Initialise the screen for mgl
%   Opens a screen, sets the units to visual angle coordinates
%   input: screenNumber - 0, 1, or 2
%                           0 is a floating window, 1 is the whole screen,
%                           2 is external display
%           measurements - optional [distance to screen, w, h] in cm
%                           assume [57,[16 12]] by default
%
%
%
%   see also: closeScreen, mglClose
%
%
%
% ma - 2015-11-4

% error checking to see whether the user has provided some measurements or
% not, if not, just use a placeholder default

if nargin < 2
    % user hasn't inputted measurements
    measurements = [57, 16, 12];
end

if nargin < 1
    % user hasn't inputted anything
    screenNumber = 0;
    disp('(initialiseScreen) using screenNumber = 0 as a default...!')
end

% error check
if ~isnumeric(screenNumber) || ~any(screenNumber == [0 1 2])
    error('(initializeScreen) problems opening a screen for you')
end

% set some variables that we can use
screenSize = [800, 600]; % Change the screen dimensions
refreshRate = 60;
colorDepth = 32;

% actually open the screen
mglOpen(screenNumber, screenSize(1), screenSize(2), refreshRate, colorDepth);
mglMoveWindow(50,1000);

% grab the first value stored in the "measurements" variable. That's the
% distance -- then grab the 2nd and 3rd together by using 
% measurements([2 3])
mglVisualAngleCoordinates(measurements(1), measurements([2 3]));
fprintf('(initializeScreen) Using visual angle coordinates\n')
fprintf('(initializeScreen) d=%.1f / w=%.1f / h=%.1f\n', measurements)

% we might also want to clear the screen, this first time - just to make
% sure there are any weird artefacts
% mglClearScreen(0) % to black 
mglClearScreen(0.5) % for gray

% screenNumber will just pass through this function and be returned from
% the function.

% another thing we could do here is to return screenNumber = -1 to indicate
% that something went wrong, then  you could check outside the function and
% terminate your program ?!

end

