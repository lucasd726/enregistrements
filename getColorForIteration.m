function color = getColorForIteration(a)
    % Predefined set of colors
    colors = {'r', 'g', 'b', 'c', 'm', 'y', 'k'};
    
    % Get color index based on the value of 'a'
    color_index = mod(a - 1, numel(colors)) + 1;
    
    % Retrieve color based on the color index
    color = colors{color_index};
end