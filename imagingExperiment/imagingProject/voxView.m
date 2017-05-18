function [h] = voxView(T1, T2, R2, fignum)
% voxView - This interactive viewer displays different statistical maps on
% the mean fMRI slice.
%         - Interactivity by key press: 'f' for mean fMRI, 't' for t1 map,
%         'r' for r2 map, 'q' to quit the program
%
%
%
% ma 2015-12-14 see also: statsAssignment, returnStats,
% makeDM

try
    load('sliceData.mat')
catch
    error('Cannot find the .mat file! Please load it...')
end

% Create the meanSlice
meanSlice = sum(array,3)/size(array,3);

% if statement which checks the number of arguments, then gives a figure a
% handle, a sort of indirect object reference

if nargin < 4
    h = figure(); % call figure like this, then matlab makes a new window
else
    h = figure(fignum); % provide a number
end

% Give the figure a name
set(h, 'Name', hdr.img_name);

% change a property
set(h, 'KeyPressFcn', @keyPress);
set(h, 'toolbar', 'none');


% We want to overlay the statistical image(s) on the mean fMRI...
% and each time, we want to update the field called 'currenMap'.
currentMap = meanSlice;

% Make a struct with everything in it
data = struct('array', array, 'hdr', hdr, 'meanSlice', meanSlice, 't1Map', T1, ...
    't2Map', T2, 'r2Map', R2, 'currentMap', currentMap);

data.cmap = gray(256);
% data.dataLimits = prctile(array(:), [5 95]); <---- this function doesn't
% like this

set(h,'UserData', data);

% Draw the stat map
drawMap(h);

end


function [] = keyPress(h, event)
% keyPress - Hooks up specified keys to whatever the function wants to use
% them for
%
% ma 2015-12-14

data = get(h, 'UserData');

%set the keys to interact with
switch lower(event.Key)
    case {'f'}
        disp('meanFMRI')
        data.currentMap = data.meanSlice;
        data.cmap = gray;
       
    case {'r'}
        disp('r2 map')
        data.currentMap = data.r2Map;
        data.cmap = hot;
    case {'t'}
        disp('t1 map, faces vs houses')
        data.currentMap = data.t1Map;
        data.cmap = jet;
    case {'y'}
        disp('t2 map, houses vs faces')
        data.currentMap = data.t2Map;
        data.cmap = jet;
    case {'q'}
        disp('Now, wasn''t that FUN?')
        close(h);
        return
end

% data.currentMap(45,38) % Just some checking, that the currentMap value is actually changing

% Set the data, and give it to drawMap
set(h, 'UserData', data);

drawMap(h);

end

    
    function [] = drawMap(h)
    % drawMap - draw the current Map in the figure window
    %
    %
    %
    % ma 2015-12-14
    
    %Get the data
    figure(h)
    data  = get(h, 'UserData');
    img = data.currentMap;
    
    % set limits
    imagesc(img);
    colormap(data.cmap)
    colorbar
    axis image
    axis ij
    
    %  labels
    
    
%     t = text(0,0, ['Map: ' num2str(data.currentMap, '%d')]);
%     set(t, 'color', 'w', 'fontsize', 14, 'verticalalignment', 'top');

% Couldn't get the labels to work...
    
    end
    
    
    
    

    
        
   






