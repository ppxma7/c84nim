function [result] = myFunc (A, B)
%my Func - function practice
%
%
%
%
% ma 2015-11-27


result = B/A;

% 1. Calling myFunc without input arguments will lead to an error
%
% 2. myFunc(2, 6) will provide ans = 4
%       A = 6, B = 2, thus with extreme computational effort, MATLAB spits ..
%        out a 4 (6-2=4)
%
% 3. reassign myFunc(2,6) to 'bla', so each time you call 'bla', MATLAB will
%       spit out a 4
%
% 4. Creating variables 'A' and 'B', e.g. A = 5, B = 5. If we call 'bla', ..
%       it will still return a 4 ( since 'bla' = myFunc(2,6))...
%       If we call myFunc(A,B), it will return a 0 (5-5 = 0). 
%
% 5. A = 10, B = 100; assign variables, but suppress output
%       bla = myFunc(A,B); now if we call bla, we will get 90.
%
% 6. myFunc(B,A). 
%              This is the A-star level question.
%
%              Let's say we assign A = 5, B = 12.
%              If we call myFunc(A,B), then ans = 7, as expected. (12-5 =7)
%              If we call myFunc(B,A), then ans = -7, why?
%              
%              The function says that 'whatever I see in the first
%              position (first argument), I'm gonna take it away from whatever I see in the
%              second position (second argument), regardless of what the
%              'outside world' wants me to believe.
%
%              Honey badger doesn't care.


end