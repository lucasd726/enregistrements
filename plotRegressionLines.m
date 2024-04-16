function plotRegressionLines(meanFx, coefficients_low, coefficients_high, color)
    % Plot regression lines for low and high slopes
    Fx_fit_low = linspace(0, max(meanFx), 100);
    Fy_fit_low = polyval(coefficients_low, Fx_fit_low);
    plot(Fx_fit_low, Fy_fit_low, 'Color', color);

    Fx_fit_high = linspace(0, max(meanFx), 100);
    Fy_fit_high = polyval(coefficients_high, Fx_fit_high);
    plot(Fx_fit_high, Fy_fit_high, 'Color', color);

    hold on;
end