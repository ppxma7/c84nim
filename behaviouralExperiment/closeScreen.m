function [ ] = closeScreen( )
%closeScreen Closes the mglScreen and displays a farewell message
%   Closes mgl screen and displays a farewell message in terminal window
%   
% 
%   see also: mglTextDraw, mglFlush, mglOpen, mglClose
%
% ma - 2015-11-4

% Clear the screen
mglClearScreen(0.5) %grey

% Prepare some text
mglTextSet('Helvetica', 18, [1 1 1], 0, 0, 0);
mglTextDraw('Thank you for participating',[0 1.0]);
mglTextDraw('Press any key to close window',[0 -1.0])

mglFlush;

% Now we play the (user) waiting game...

pause()

% Close the screen
mglClose()
disp('See You Space Cowboy')

end

