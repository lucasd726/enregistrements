function [coefficients_low, coefficients_high] = performLinearRegression(meanFx, meanFy)
    % Perform linear regression for low and high slopes

    % get Z and the angles for each point 
    Z = meanFx + 1j*meanFy;
    angles = angle(Z);

    [~, pos_min_angle] = min(rad2deg(angles));
    [~, pos_max_angle] = max(rad2deg(angles));

    % Low slope
    coefficients_low = polyfit([0, meanFx(pos_min_angle)], [0, meanFy(pos_min_angle)], 1);

    % High slope
    coefficients_high = polyfit([0, meanFx(pos_max_angle)], [0, meanFy(pos_max_angle)], 1);

end