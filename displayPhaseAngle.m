function displayPhaseAngle(meanFx, meanFy, color, label, iteration)
    
    % Calculate phase angle
    angles_deg = rad2deg(atan(meanFy ./ meanFx));

    % Determine text position 
    text_y = 2.5 + iteration*0.3; % Adjust as needed for proper positioning

    % Display phase angle on the graph

    % Create the text string with all parts concatenated within one string
    text_str = sprintf('Phase %s: %f - %f degrees', strjoin(label), min(angles_deg), max(angles_deg));

    % Plot the text with proper concatenation
    text(0.1, text_y, text_str, 'Color', color, 'FontSize', 18);

end