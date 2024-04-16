function plotRegressionAndFilledAreas(meanFx, meanFy, color, label, iteration)
    % Perform linear regression
    [coefficients_low, coefficients_high] = performLinearRegression(meanFx, meanFy);

    % Plot regression lines
    plotRegressionLines(meanFx, coefficients_low, coefficients_high, color);

    % Plot filled areas
    plotFilledAreas(meanFx, coefficients_low, coefficients_high, color);

    % Display phase angle
    displayPhaseAngle(meanFx, meanFy, color, label, iteration);
end