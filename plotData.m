function plotData(meanFx, meanFy, color, label, index, texte, line)
% Plot mean points

if line
    % If line is true, plot dashed lines
    plot(meanFx, meanFy, '-', 'Color', color);
else
    % If line is false, plot individual points
    plot(meanFx, meanFy, 'o', 'Color', color);
end

hold on;
% Add labels

if (texte)

    for i = 1:length(meanFx)
        % text(meanFx(i), meanFy(i), ['  ' label ' ' index{i}], 'Color', color);
    end

end

end