function displayPhaseAngle(meanFx, meanFy, color, label, iteration)
    
    % Calculate phase angle
    angles_deg = rad2deg(atan(meanFy ./ meanFx));

    % Determine text position 
    text_y = 2.5 + iteration*0.2; % Adjust as needed for proper positioning

    % Display phase angle on the graph

    text(0.1, text_y, ['Phase ' label ': ' num2str(min(angles_deg)) ' - ' num2str(max(angles_deg)) ' degrees'], 'Color', color, 'FontSize', 18);

end