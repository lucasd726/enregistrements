function [filtered_meanFx, filtered_meanFy, filtered_index] = filter_Fx_Fy(meanFx, meanFy, index)


    angles = compute_angles(meanFx, meanFy);
    mean_angles = mean(angles);
    std_dev_angles = std(angles);
    
    % Define the lower and upper bounds for filtering
    lower_bound = - 1000; % mean_angles - 2*std_dev_angles (95 % of values)
    upper_bound = 1000; % mean_angles + 2*std_dev_angles
    
    % Filter perlite_meanFx_combined and perlite_meanFy_combined based on filtered angles
    filtered_meanFx = meanFx(angles >= lower_bound & angles <= upper_bound);
    filtered_meanFy = meanFy(angles >= lower_bound & angles <= upper_bound);
    filtered_index = index(angles >= lower_bound & angles <= upper_bound);
    
end   