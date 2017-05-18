function [whichResponse, correct] = presentTrials(stimulusOri, validKeyCodes)
%presentTrials - A big for loop that presents each trial
%               
%
% ma 2015-11-11 - remade for leaner code

mglClearScreen(0.5);

% line details
lineSize = 1;
lineColour = [1 1 1];
antiAlias = 1;

r = 5; %degrees
% negative sign to make anticlockwise negative
x1 = r.*cosd(-stimulusOri + 90); %the +90 to make it vertical
y1 = r.*sind(-stimulusOri + 90);

mglLines2(-x1, -y1, x1, y1, lineSize, lineColour, antiAlias);
mglFlush();

% keys
response = [];
while ~any(response)
    response = mglGetKeys(validKeyCodes);
end

% convert response of [0 1] into a 1 or a 2
whichResponse = find(response);

if stimulusOri < 0 && whichResponse == 1
    %if the stimulus was anticlockwise and the subject was correct
    correct = 1;
elseif stimulusOri > 0 && whichResponse == 2
    %if the stimulus was clockwise and the suject was correct
    correct = 1;
else
    correct = 0;
end

mglWaitSecs(0.5);
mglClearScreen(0.5);
mglFlush();

% 
% 
% r = nan(nTrials,1);
% 
% 
% 
% for iTrial = 1:nTrials; 
%      a = randi(orientations);
%      
%      % If we print a, then for data analysis, we know which orientation was
%      % presented...
%      % Also, change a to make the line bigger or smaller
%      a
%      
%      mglClearScreen(0.5);
%      mglLines2((2*sin(a*pi/180)), (2*cos(a*pi/180)), (-2*sin(a*pi/180)), (-2*cos(a*pi/180)), 1, [1 1 1], 1);
%      mglFlush;
%    
%      pause()
%          % Wait for user input - without this, if user presses a 1 or a 2,
%          % then this will provide the answer to the first trial, since the
%          % keyboard is being checked. 
%          % Probably a more efficient way to do this, but this checks the
%          % truth of whether a '1' or a '2' was pressed
%          
%      keycode_one = mglCharToKeycode( {'1'} );
%      keycode_two = mglCharToKeycode( {'2'} );
%      
%      while true
%          % infinite loop 
%    
%          % k = mglGetKeys();
%          % k returns 0 0 0 1 0 0 0 1 0 ...
%          % a table with info about which button was pressed
%          
%          k = mglGetKeys(keycode_one);
%          % If any of the k's (2 entries are true)
%          if any(k == 1)
%              disp('user pressed a 1')
%              r(iTrial) = 1;
%              break %break the while loop
%          end
%          
%          l = mglGetKeys(keycode_two);
%          if any(l ==1)
%              disp('user pressed a 2')
%              r(iTrial) = 2;
%              break
%          end
%      end
%      mglWaitSecs(0.5);    
%      mglClearScreen(0.5);
%      
% end




end

