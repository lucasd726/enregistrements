function plotFilledAreas(meanFx, coefficients_low, coefficients_high, color)
    % Plot filled areas between regression lines
    Fx_fit_low = linspace(0, max(meanFx), 100);
    Fy_fit_low = polyval(coefficients_low, Fx_fit_low);

    Fx_fit_high = linspace(0, max(meanFx), 100);
    Fy_fit_high = polyval(coefficients_high, Fx_fit_high);

    fill([Fx_fit_low, fliplr(Fx_fit_high)], [Fy_fit_low, fliplr(Fy_fit_high)], color, 'FaceAlpha', 0.3);
end