function [filename ] = fileNameDefault (  )
%fileNameDefault - defaults to a filename if user doesn't enter one
%
%
% ma 2015-11-11

filename = input('Enter the filename: ', 's');

if isempty(filename)
    filename = datestr(now,'yyyymmdd-HHMMSS'); 
end


end

