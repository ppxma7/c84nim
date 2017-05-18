function [tag] = mySliceView (fignum)
% mySliceView - This will open up a user chosen slice from a 3D image, and
% allow some user interaction
%
%   usage: mySliceView(INTEGER)
%                   e.g. mySliceView(1)
%
%
% ma 2015-11-18

% See if we can try and load the brain image automatically...
try
    load('sliceData.mat')
catch
    error('Cannot find the .mat file! Please load it...')
end

% Check if the file extension is nifti or hdr
% dot = regexp(filename,'\.');
% switch (filename(dot+1:end))
%     case {hdr}
%         disp 'hdr file'
%     case {nii}
%         disp 'nifti file'
%     otherwise
%         error('Not a hdr nor a nifti!')
% end



% if statement which checks the number of arguments, then gives a figure a
% handle, a sort of indirect object reference

if nargin < 1
    tag = figure(); % call figure like this, then matlab makes a new window
else
    tag = figure(fignum); % provide a number
end

% Give the figure a name
set(tag, 'Name', hdr.img_name);

% change a property
set(tag, 'KeyPressFcn', @keyPress);
set(tag, 'toolbar', 'none');

set(tag, 'WindowScrollWheelFcn', {@scroll, gcf});


% we want to change the orientation by a keypress 'o'

orientation = 1;
sliceNum = round(size(array, orientation).*0.67);
s = returnSlice(array, sliceNum, orientation); 

% Make a struct with everything in it
data = struct('array', array, 'hdr', hdr, 'currentSliceNum', sliceNum, ...
    'currentOrientation', orientation, 'currentSlice', s);

data.cmap = gray(256);
data.dataLimits = prctile(array(:), [5 95]);

set(tag,'UserData', data);

drawSlice(tag);

end

function [s] = returnSlice(array, sliceNum, orientation)
% returnSlice - This function returns a user-specified slice
%
%
%
% ma 2015-11-18

% If statement to switch the orientation
if orientation == 1
    s = squeeze(array(sliceNum,:,:));
    

elseif orientation == 2
% need to squeeze to get rid of singleton dimension
    s = squeeze(array(:,sliceNum,:));

elseif orientation == 3

    s = array(:,:,sliceNum);

else
    error('(!) orientation not valid. Needs to be between 1 and 3')
end


end

function [] = keyPress(tag, event)


data = get(tag, 'UserData');

%set the keys to interact with
switch lower(event.Key)
    case 'uparrow'
        data.currentSliceNum = data.currentSliceNum + 1; % add one to go up
    case 'downarrow'
        data.currentSliceNum = data.currentSliceNum - 1;
    case {'o'}
        %Divide the currentOrientation (1) by itself+1 divided by 3
        data.currentOrientation = rem(data.currentOrientation +1, 3) + 1;
    case {'q'}
        disp('Laters')
        close(tag);
        return
end

%Check we don't go below zero
if data.currentSliceNum < 1
    disp ('(keyPress) Whoooa there! You can''t go below 0!')
    data.currentSliceNum = 1;
end

%Check we don't go above the max
if data.currentSliceNum > size(data.array, data.currentOrientation)
    data.currentSliceNum = size(data.array, data.currentOrientation);
    disp ('That slice number is too damn high! Staying here')
end

%Now we put the newly selected slice in place of the old one
data.currentSlice = returnSlice(data.array, data.currentSliceNum, ...
    data.currentOrientation);

set(tag, 'UserData', data);

drawSlice(tag);



end

    
    function [] = scroll(func, callbackdata, tag)
    % scroll - use the scroll on the mouse to go through the slices faster
    %
    %
    data = get(tag, 'UserData');
    
    if callbackdata.VerticalScrollCount > 0
        data.currentSliceNum = data.currentSliceNum - 2;
    elseif callbackdata.VerticalScrollCount < 0
       data.currentSliceNum = data.currentSliceNum + 2;
    end
    
%     Go back to the top slice if go below 0, go to the bottom if go more
%     than the max
    if data.currentSliceNum < 1
        disp ('(scroll) Whooooooa, back to the top!')
        data.currentSliceNum = size(data.array, data.currentOrientation);
    elseif data.currentSliceNum > size(data.array, data.currentOrientation)
        data.currentSliceNum = 1;
        disp ('That slice number is too damn high! Going back to the bottom')
    end

    
% Now we put the newly selected slice in place of the old one
data.currentSlice = returnSlice(data.array, data.currentSliceNum, ... 
    data.currentOrientation);

set(tag, 'UserData', data);
    
    drawSlice(tag);
      
    end

    function [] = drawSlice(tag)
    % drawSlice - draw the current slice in the figure window
    %
    %
    %
    % 
    
    %Get the data
    figure(tag)
    data  = get(tag, 'UserData');
    img = data.currentSlice;
    
    % set limits
    imagesc(img, data.dataLimits);
    colormap(data.cmap)
    colorbar
    axis image
    axis ij
    
    %labels
    t = text(0,0, ['Slice: ' num2str(data.currentSliceNum, '%d')]);
    set(t, 'color', 'w', 'fontsize', 14, 'verticalalignment', 'top');
    
    end
    
    
    
    

    
        
   






