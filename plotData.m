function plotData(meanFx, meanFy, color, label, index, texte, line)
% Plot mean points

% OLD CODE : to see an animated line
% filename = 'animated_plot.gif'; % Define the filename for the GIF
% h = animatedline('Color', color);

% Plot subsequent points or lines one by one

if line

    % OLD CODE : to see an animated line
    % for i = 1:length(meanFx)
    %     addpoints(h,meanFx(i), meanFy(i));
    %     drawnow
    % end

    plot(meanFx, meanFy,  '-', 'Color', color);

else

    % If line is false, plot individual points
    plot(meanFx, meanFy, 'o', 'Color', color);

end

% OLD CODE : to record the animated line
% frame = getframe(1);
% im = frame2im(frame);
% [imind,cm] = rgb2ind(im,256);
% if i == 1
%     imwrite(imind,cm,filename,'gif','Loopcount',inf);
% else
%     imwrite(imind,cm,filename,'gif','WriteMode','append');
% end


hold on;

% Add labels

if (texte)

    for i = 1:length(meanFx)
        % text(meanFx(i), meanFy(i), ['  ' label ' ' index{i}], 'Color', color);
    end

end

end