function [meanFx, meanFy] = loadMeanData(directory, fileNamePrefix, numFiles, index)
    meanFx = zeros(1, numFiles);
    meanFy = zeros(1, numFiles);
    for i = 1:numFiles
        filename = fullfile(directory, [fileNamePrefix '_' index{i} '.mat']);
        if exist(filename, 'file')
            data = load(filename);
            meanFx(i) = mean(data.Fx(1:end-1000));
            meanFy(i) = mean(data.Fy(1:end-1000));       
        end
    end

end