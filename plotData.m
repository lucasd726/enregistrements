function plotData(meanFx, meanFy, color, label, index)
    % Plot mean points
    plot(meanFx, meanFy, 'o', 'Color', color);
    hold on;
    % Add labels
    for i = 1:length(meanFx)
        text(meanFx(i), meanFy(i), ['  ' label ' ' index{i}], 'Color', color);
    end
end