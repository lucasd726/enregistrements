function main_line()

    close all
    clc
    
    % By default we don't plot the boxplots, we don't have samples and we
    % don't merge the points
    boxplots = false;
    sample = false;
    % merge = false;

    % Decide if we want to take the sample POINTS measures
    prompt = 'Do you want to take the sample POINTS measures (and see steps) ? (y/n): ';
    user_response = input(prompt, 's');

    if strcmpi(user_response, 'y')

        currentFolder = pwd;
        paramsFilePath = fullfile(currentFolder, 'params_points.pssettings');
        pdfFilePath = fullfile(currentFolder, 'prez_1-64-72.pdf');
        winopen(paramsFilePath);
        winopen(pdfFilePath);

    end

    prompt = 'Do you want to take the sample LINE measures (and see steps) ? (y/n): ';
    user_response = input(prompt, 's');

    % Decide if we want to take the sample LINE measures
    if strcmpi(user_response, 'y')

        currentFolder = pwd;
        paramsFilePath = fullfile(currentFolder, 'params_line.pssettings');
        pdfFilePath = fullfile(currentFolder, 'prez_1-64-72.pdf');
        winopen(paramsFilePath);
        winopen(pdfFilePath);

    end

    % Decide how many benchmarks we want to use
    user = getenv('username');
    startpath = ['C:\Users\',user,'\Desktop\PRI\enregistrements\'];
    n_essais = input('Enter the number of benchmarks to use : ');

    number_of_files = zeros(1, n_essais);
    new_number_of_files = zeros(1, n_essais);
    FullFileNames_all = cell(1, 200);
    memory_FullFileNames = 0;
    fullfile_idx = 1;

    if n_essais == 2 && ~input('Do you want to manually select files? (1 for Yes, 0 for No): ') 

            % Load file names from a saved MAT file
            try

                load('file_names_data.mat'); % Load previously saved file names
                fprintf('File names loaded from saved data.\n');

            catch
                
                error('Error loading file names. Please ensure that file_names_data.mat exists.');

            end


    else

        for k = 1 : n_essais

            FullFileNames = usergetfiles(startpath);
            % Cumulatively sum the lengths of FullFileNames
            number_of_files(k) = memory_FullFileNames + length(FullFileNames);
            memory_FullFileNames = number_of_files(k);

            FullFileNames_all(fullfile_idx : number_of_files(k)) = FullFileNames;
            fullfile_idx = 1 + number_of_files(k);

            % Save the file names to a MAT file to replace the default benchmarks
            % save('file_names_data.mat', 'FullFileNames_all', 'number_of_files', 'fullfile_idx');

        end

    end

    length_sample = 0;
    % Ask the user if they want to load sample files
    prompt = 'Do you want to load sample files? (y/n): ';
    user_response = input(prompt, 's');

    if strcmpi(user_response, 'y')

        sample = true;
        FullFileNames = usergetfiles(startpath);
        length_sample = length(FullFileNames);
        FullFileNames_all(fullfile_idx : fullfile_idx + length_sample - 1) = FullFileNames;      

    end

    if ~iscell(FullFileNames_all)
        error('FullFileNames_all must be a cell ...')
    end

    prompt = 'Do you want to plot the boxplots ? (y/n): ';
    user_response = input(prompt, 's');

    if strcmpi(user_response, 'y')

        boxplots = true;

    end

    % index
    index = cell(1, n_essais + 1);

    % 10 names maximum
    names = cell(1, 10);
    iteration = 0;

    % values for points measures
    meanFx = zeros(1, length(FullFileNames_all));
    meanFy = zeros(1, length(FullFileNames_all));

    % a and u are used later for the index
    a = 0;
    u = 0;

    % euclidean = false;

    % line measures is initially false
    line = false;
    check_points = false;
    check_line = false;

    % Initialize cell arrays to store Fx_plot, Fy_plot, and their sizes
    all_Fx_plot = cell(1, 10);
    all_Fy_plot = cell(1, 10);

    % clean means that we keep 95 % of the values, but it is disabled (+/- 2 sigma)
    all_Fx_plot_clean = cell(1, 10);
    all_Fy_plot_clean = cell(1, 10);

    % merge means points measures with same name are merged (like perlite1
    % and perlite 2)
    all_Fx_plot_clean_merge = cell(1, 10);
    all_Fy_plot_clean_merge = cell(1, 10);
    common_names = cell(1, 10);

    all_angle_clean = cell(1, 10);
    all_magnitude_clean = cell(1, 10);

    % OLD CODE below was used to normalize the magnitude and phase angles
    % all_angle_clean_y = cell(1, 10);
    % all_magnitude_clean_y = cell(1, 10);

    % READ AND PROCESS FILES
    for i=1:numel(FullFileNames_all)

        if isempty(FullFileNames_all{i})
            
            break;  % Exit the loop when encountering the first non-initialized cell

        end

        FullFileName = FullFileNames_all{i}; % acces to i-th filename
        offset = strfind(FullFileName, '.mat')-1; % remove extension from filename
        filename_clean = FullFileName(1:offset);

        % get infos from cleaned filename
        FileName = strsplit(filename_clean,'\');
        FileName = FileName{end};
        infos = strsplit(FileName,'_');
        type = infos{1}; % type is benchmarks or sample
        sample_name = infos{2}; % name is perlite1, perlite2, perliteline1, etc.

        % the code below is due to the fact that we don't have index for
        % line measurements
        if exist('infos', 'var') && numel(infos) >= 3 && ~isempty(infos{3})
            sample_index = infos{3};
        else
            sample_index = 1;
        end

        % load file-i
        load(FullFileName, 'Fx', 'Fy', 'Tinterval');

        %define time array
        t = 0:Tinterval:Tinterval*(numel(Fx)-1);

        % check if it is a line measurement
        line = contains(sample_name, 'line', 'IgnoreCase', true);
        
        % check boundaries for measures
        if check_points == false && line == false

            f10 = figure;
            plot(t,Fy,'r',t,Fx,'b'), xlabel('t(s)'), ylabel('V'), axis tight, legend('Fy points','Fx points','Location','southwest')
            waitforbuttonpress; p1 = get(gca,'CurrentPoint');
            waitforbuttonpress; p2 = get(gca,'CurrentPoint');
            first = find(t <= p1(1,1)); first_points = first(end);
            last = find(t <= p2(1,1)); last_points = last(end);
            close(f10);
            check_points = true;

        end

        % check boundaries again for other measures
        if check_line == false && line == true

            f10 = figure;
            plot(t,Fy,'r',t,Fx,'b'), xlabel('t(s)'), ylabel('V'), axis tight, legend('Fy line','Fx line','Location','southwest')
            waitforbuttonpress; p1 = get(gca,'CurrentPoint');
            waitforbuttonpress; p2 = get(gca,'CurrentPoint');
            first = find(t <= p1(1,1)); first_line = first(end);
            last = find(t <= p2(1,1)); last_line = last(end);
            close(f10);
            check_line = true;

        end

        if (line == false)
            % compute mean values for point measures
            meanFx(i) = mean(Fx(first_points:last_points));
            meanFy(i) = mean(Fy(first_points:last_points));
        end
        

        % Append the name of the new measures to names{}
        if ~any(strcmp(sample_name, names))
            
            a = a + 1;
            names{a} = sample_name;
            all_Fx_plot{a} = [];
            all_Fy_plot{a} = [];
            index{a} = cell(1, 100);
            u = 0;

        end

        u = u + 1;
        index{a}{u} = sample_index;

        % look for the idx for the name of the current measures
        idx = find(strcmp(names, sample_name));

        % Filter Fx values that are above 2 in the specified range
        filtered_Fx = Fx(first_line:last_line);
        filtered_Fy = Fy(first_line:last_line);
        valid_indices = filtered_Fx > 3;

        if line
            all_Fx_plot{idx} = [all_Fx_plot{idx}, filtered_Fx(valid_indices)];
            all_Fy_plot{idx} = [all_Fy_plot{idx}, filtered_Fy(valid_indices)];
        else
            all_Fx_plot{idx} = [all_Fx_plot{idx}, meanFx(i)];
            all_Fy_plot{idx} = [all_Fy_plot{idx}, meanFy(i)];
        end

    end

    % Set idx to its max value

    % Reset idx to the maximum non-null value
    non_empty_indices = find(~cellfun('isempty', names));
    idx = max(non_empty_indices);

    % Add 1 to the index if not already done
    if (sample == false)
        idx = idx + 1;
    end     

    % For the boxplots later
    angles_boxplots = cell(1, idx - 1);

    % OLD CODE (to normalize the impedance plane)
    % angle_clean_mean_perlite_vector = zeros(1, 20);

    % for y = 1 : idx - 1
    % 
    %     [all_Fx_plot_clean{y}, all_Fy_plot_clean{y}, index_clean] = filter_Fx_Fy(all_Fx_plot{y}, all_Fy_plot{y}, index{y});
    % 
    %     if contains(names{y}, 'perlite') % Check if 'perlite' is part of the name
    % 
    %         % Extract the number following 'perlite'
    %         number_str = regexp(names{y}, 'perlite(\d+)', 'tokens');
    % 
    %         if ~isempty(number_str)
    %             number = str2double(number_str{1}{1}); % Convert the extracted number to a double
    % 
    %             Z_y = all_Fx_plot_clean{y} + 1j*all_Fy_plot_clean{y};
    %             all_angle_clean_y{y} = rad2deg(angle(Z_y)); % angles in degrees
    %             angle_clean_mean_perlite = mean(all_angle_clean_y{y});
    % 
    %             % Store the mean angle in the cell array at the correct index
    %             angle_clean_mean_perlite_vector(number) = angle_clean_mean_perlite;
    % 
    %         end
    % 
    %     end
    % 
    % end


    % for y = 1 : idx - 1
    % 
    %     [all_Fx_plot_clean{y}, all_Fy_plot_clean{y}, index_clean] = filter_Fx_Fy(all_Fx_plot{y}, all_Fy_plot{y}, index{y});
    % 
    %     % Create a new number of benchmarks files
    %     new_number_of_files(y) = length(index_clean);
    % 
    %     % for boxplots
    %     angles_boxplots{y} = compute_angles(all_Fx_plot{y}, all_Fy_plot{y});
    % 
    %     % Extract the number from the name if present
    %     number_str_2 = regexp(names{y}, '\d+', 'match');
    % 
    %     if ~isempty(number_str_2)
    % 
    %         number = str2double(number_str_2{1, 1}); % Convert the extracted number to a double
    % 
    %         Z_y = all_Fx_plot_clean{y} + 1j*all_Fy_plot_clean{y};
    %         all_angle_clean_y{y} = rad2deg(angle(Z_y)); % angles in degrees
    %         all_magnitude_clean_y{y} = abs(Z_y); % magnitudes of each element in Z_y
    %         angle_clean_mean_y = mean(all_angle_clean_y{y});
    %         magnitude_clean_max_y = max(all_magnitude_clean_y{y});
    % 
    %         all_angle_clean_y{y} = (all_angle_clean_y{y} - angle_clean_mean_perlite_vector(number) + 45);
    %         all_magnitude_clean_y{y} = all_magnitude_clean_y{y}/magnitude_clean_max_y;
    % 
    %     end
    % 
    % 
    %     % Convert angles from degrees to radians for calculation
    %     angles_rad = deg2rad(all_angle_clean_y{y});
    % 
    %     % Compute Fx and Fy from the magnitudes and angles
    %     all_Fx_plot_clean{y} = all_magnitude_clean_y{y} .* cos(angles_rad);
    %     all_Fy_plot_clean{y} = all_magnitude_clean_y{y} .* sin(angles_rad);
    % 
    %     % Get the color for plotting
    %     color = getColorForIteration(y);
    % 
    %     if (~merge)
    % 
    %         % Plot data
    %         plotData(all_Fx_plot_clean{y}, all_Fy_plot_clean{y}, color, names{y}, index_clean, 1);
    %         plotRegressionAndFilledAreas(all_Fx_plot_clean{y}, all_Fy_plot_clean{y}, color, names(y), iteration);
    %         iteration = iteration + 1;
    % 
    %     end
    % 
    % end


    for y = 1 : idx - 1
    
        % It will be different for lines and not lines
        line = contains(names{y}, 'line', 'IgnoreCase', true);

        if (line)

            indexArray = cellfun(@(x) num2str(x), num2cell(1:length(all_Fx_plot{y})), 'UniformOutput', false);
            [all_Fx_plot_clean{y}, all_Fy_plot_clean{y}, index_clean] = filter_Fx_Fy(all_Fx_plot{y}, all_Fy_plot{y}, indexArray);

        else

            [all_Fx_plot_clean{y}, all_Fy_plot_clean{y}, index_clean] = filter_Fx_Fy(all_Fx_plot{y}, all_Fy_plot{y}, index{y});

        end

        % Create a new number of benchmarks files
        new_number_of_files(y) = length(index_clean);

        % This code below computes stats like mean value, standard
        % deviation, etc.
        if strcmp(names{y}, 'perlite') % change name to get stats
            compute_stats(all_Fx_plot{y}, all_Fy_plot{y}, names{y});
        end
    
        % for boxplots
        angles_boxplots{y} = compute_angles(all_Fx_plot{y}, all_Fy_plot{y});

        % Get the color for plotting
        color = getColorForIteration(y);

        % Plot data
        plotData(all_Fx_plot_clean{y}, all_Fy_plot_clean{y}, color, names{y}, index_clean, 1, line);
        plotRegressionAndFilledAreas(all_Fx_plot_clean{y}, all_Fy_plot_clean{y}, color, names(y), iteration);
        iteration = iteration + 1;

    end


    % OLD CODE next : merge samples of points with similar names :
    % perlite1, perlite2
    % a = 0;
    % 
    % % Loop through the data and group by common prefix
    % for y = 1:idx-1
    %     % Extract the common prefix (name without the number at the end)
    %     nameParts = regexp(names{y}, '(\D+)(\d+)', 'tokens');
    % 
    %     if ~isempty(nameParts)
    % 
    %         commonName = nameParts{1}{1}; % Get the common name part (like 'perlite')
    % 
    %         if ~any(strcmp(commonName, common_names))
    % 
    %             a = a + 1;
    %             common_names{a} = commonName;
    % 
    %         end
    % 
    %         idx = find(strcmp(commonName, common_names));
    % 
    %         % Append data to the existing entry
    %         all_Fx_plot_clean_merge{idx} = [all_Fx_plot_clean_merge{idx}, all_Fx_plot_clean{y}];
    %         all_Fy_plot_clean_merge{idx} = [all_Fy_plot_clean_merge{idx}, all_Fy_plot_clean{y}];
    % 
    % 
    %     end
    % 
    % end


    % for k = 1:a
    % 
    %     % Get the color for plotting
    %     color = getColorForIteration(a);
    % 
    %     commonName = common_names{a};
    % 
    %     % Plot merged data
    %     indexArray = cellfun(@(x) num2str(x), num2cell(1:length(all_Fx_plot_clean_merge{a})), 'UniformOutput', false);
    %     plotData(all_Fx_plot_clean_merge{a}, all_Fy_plot_clean_merge{a}, color, commonName, indexArray, 1);
    %     plotRegressionAndFilledAreas(all_Fx_plot_clean_merge{a}, all_Fy_plot_clean_merge{a}, color, {commonName}, iteration);
    % 
    %     iteration = iteration + 1;
    %     hold on
    % 
    % end


    % title for labels
    xlabel('Resistance Fx (in V)', 'FontSize', 14);
    ylabel('Reactance Fy (in V)', 'FontSize', 14);

    % the rest of the code is comparison with a sample of points (Rule of
    % mixtures)
    new_number_of_files = cumsum(new_number_of_files);
    all_meanFx_clean = zeros(1, new_number_of_files(n_essais));
    all_meanFy_clean = zeros(1, new_number_of_files(n_essais));

    index_Fx = 1;
    index_Fy = 1;

    if (sample == true)

        % Not clean yet
        meanFx_sample = all_Fx_plot{idx};
        meanFy_sample = all_Fy_plot{idx};

        % It will be different for lines and not lines
        line = contains(names{idx}, 'line', 'IgnoreCase', true);

        if (line)

            indexArray = cellfun(@(x) num2str(x), num2cell(1:length(meanFx_sample)), 'UniformOutput', false);
            [meanFx_sample_clean, meanFy_sample_clean, index_clean] = filter_Fx_Fy(meanFx_sample, meanFy_sample, indexArray);

        else

            [meanFx_sample_clean, meanFy_sample_clean, index_clean] = filter_Fx_Fy(meanFx_sample, meanFy_sample, index{y});

        end


        % Plot data
        plotData(meanFx_sample_clean, meanFy_sample_clean, ...
            'k', 'sample', index_clean, 1, line);

        Z_sample_clean = meanFx_sample_clean + 1j*meanFy_sample_clean;
        angle_sample_clean = rad2deg(angle(Z_sample_clean));
        mean_all_angle_clean = zeros(1, idx - 1);

        for j = 1 : idx - 1

            all_meanFx_clean(index_Fx : new_number_of_files(j)) = all_Fx_plot_clean{j};
            index_Fx = 1 + new_number_of_files(j);

            all_meanFy_clean(index_Fy : new_number_of_files(j)) = all_Fy_plot_clean{j};
            index_Fy = 1 + new_number_of_files(j);

            Z_j = all_Fx_plot_clean{j} + 1j*all_Fy_plot_clean{j};
            all_angle_clean{j} = rad2deg(angle(Z_j));  % angles in degrees
            all_magnitude_clean{j} = abs(Z_j);   % magnitudes of each element in Z_j

            % useful to comparison using Rule of mixtures
            mean_all_angle_clean(j) = mean(all_angle_clean{j});

        end

        % Initialize counter for sample members included for each benchmark
        count_members_per_benchmark = zeros(1, idx - 1);

        % Iterate over each element in angle_sample
        for angle_val = angle_sample_clean
            % Iterate over each cell in all_angle_clean
            for j = 1:idx - 1

                % Get the minimum and maximum angle values in all_angle_clean{j}
                min_angle = min(all_angle_clean{j});
                max_angle = max(all_angle_clean{j});

                % Check if angle_val is within the interval [min_angle, max_angle]
                if angle_val >= min_angle && angle_val <= max_angle
                    % Increment counter if angle_val is within the interval
                    count_members_per_benchmark(j) = count_members_per_benchmark(j) + 1;
                    % Break out of the inner loop since angle_val is found in this interval
                    break;
                end
            end
        end

        fprintf('Percentage of sample points included by angle for each benchmark\n');

        % Print the count of members included for each j
        for j = 1:idx - 1

            % Display results

            fprintf('%s: %.2f%%\n', names{j}, (count_members_per_benchmark(j) / numel(angle_sample_clean)) * 100);

        end

        % prepare for Rule of mixtures
        mean_angle_sample_clean = mean(angle_sample_clean);
        [max_value, max_index] = max(mean_all_angle_clean);
        [min_value, min_index] = min(mean_all_angle_clean);

        range = abs(max_value - min_value);

        % Calculate probabilities only if range is non-zero (to avoid division by zero)
        if range ~= 0
            % Check if mean_angle_sample_clean is not between max_value and min_value
            if mean_angle_sample_clean < min_value
                p1 = 0;  % Set probability to 0 for the max group
                p2 = 100;  % Set probability to 100 for the min group
            elseif mean_angle_sample_clean > max_value
                p1 = 100;  % Set probability to 100 for the max group
                p2 = 0;  % Set probability to 0 for the min group
            else
                % Calculate probabilities normally
                p2 = abs(mean_angle_sample_clean - max_value)/range * 100;
                p1 = abs(mean_angle_sample_clean - min_value)/range * 100;
            end
        else
            % Handle the case where max_value equals min_value
            % For example, set p1 and p2 to 50% each in this case
            p1 = 50;
            p2 = 50;
        end

        fprintf("Probability that the sample belongs to group %s: %.2f%%\n", names{max_index}, p1);
        fprintf("Probability that the sample belongs to group %s: %.2f%%\n", names{min_index}, p2);

        fprintf("The sample belongs %.2f%% to group %s and %.2f%% to group %s\n", p1, names{max_index}, p2, names{min_index});


        % OLD CODE, nearest neighbor identification

        % Calculate distances for each sample separately
        % distances = zeros(size(meanFx_sample_clean, 2), size(all_meanFx_clean, 2));
        % 
        % % Define the number of neighbors to consider per sample
        % k = 5;
        % 
        % count = zeros(idx-1, numel(meanFx_sample_clean));
        % 
        % count_angle = zeros(idx-1, numel(meanFx_sample_clean));
        % 
        % real_sorted_distances = zeros(numel(meanFx_sample_clean), length(all_meanFx_clean));
        % real_sorted_indices = zeros(numel(meanFx_sample_clean), length(all_meanFx_clean));
        % 
        % distances_angle = zeros(size(meanFx_sample_clean, 2), size(all_meanFx_clean, 2));
        % 
        % real_sorted_distances_angle = zeros(numel(meanFx_sample_clean), length(all_meanFx_clean));
        % real_sorted_indices_angle = zeros(numel(meanFx_sample_clean), length(all_meanFx_clean));
        % 
        % Z_sample = zeros(1, numel(meanFx_sample_clean));
        % angle_sample = zeros(1, numel(meanFx_sample_clean));
        % 
        % for i = 1:numel(meanFx_sample_clean)
        % 
        %     distances(i, :) = sqrt((meanFx_sample_clean(i) - all_meanFx_clean).^2 + (meanFy_sample_clean(i) - all_meanFy_clean).^2);
        %     [sorted_distances, sorted_indices] = sort(distances(i, :));
        %     real_sorted_distances(i, :) = sorted_distances;
        %     real_sorted_indices(i, :) = sorted_indices;
        % 
        %     % Count occurrences of each type among the k nearest neighbors
        % 
        %     start_columns_all_plot_clean = 1;
        %     end_columns_all_plot_clean = 0;
        % 
        %     % get Z and the angles for each point
        %     Z = all_meanFx_clean + 1j*all_meanFy_clean;
        %     angles = rad2deg(angle(Z));
        % 
        %     Z_sample(i) = meanFx_sample_clean(i) + 1j*meanFy_sample_clean(i);
        %     angle_sample(i) = rad2deg(angle(Z_sample(i)));
        % 
        %     distances_angle(i, :) = abs(angle_sample(i) - angles);
        % 
        %     [sorted_distances_angle, sorted_indices_angle] = sort(distances_angle(i, :));
        % 
        %     real_sorted_distances_angle(i, :) = sorted_distances_angle;
        %     real_sorted_indices_angle(i, :) = sorted_indices_angle;
        % 
        %     % Count occurrences of each type among the k nearest neighbors
        % 
        % 
        %     for h = 1 : idx - 1
        % 
        %         end_columns_all_plot_clean = start_columns_all_plot_clean + length(all_Fx_plot_clean{h}) - 1;
        %         count_angle(h, i) = sum(ismember(real_sorted_indices_angle(i, 1:k), start_columns_all_plot_clean : end_columns_all_plot_clean));
        %         count(h, i) = sum(ismember(real_sorted_indices(i, 1:k), start_columns_all_plot_clean : end_columns_all_plot_clean));
        %         start_columns_all_plot_clean = start_columns_all_plot_clean + length(all_Fx_plot_clean{h});
        % 
        %     end
        % 
        % 
        %     % Compute percentages
        %     total_count = sum(sum(count, 2));
        %     percentages = sum(count, 2) ./ total_count * 100;
        % 
        %     % Compute percentages
        %     total_count_angle = sum(sum(count_angle, 2));
        %     percentages_angle = sum(count_angle, 2) ./ total_count_angle * 100;
        % 
        % 
        % end

        % Display results
        % fprintf('Percentage of 5 closest neighbors by angle for %s :\n', names{idx});
        %
        % for i = 1 : idx - 1
        %
        %     fprintf('%s: %.2f%%\n', names{i}, mean(percentages_angle(i)));
        %
        % end

        % if euclidean
        % 
        %     fprintf('Percentage of 5 closest neighbors by euclidean distance for %s :\n', names{idx});
        % 
        %     for i = 1 : idx - 1
        % 
        %         fprintf('%s: %.2f%%\n', names{i}, mean(percentages(i)));
        % 
        %     end
        % 
        % end

    end


    % Plot a boxplot with all benchmarks

    if boxplots == true

        figure;

        % Pad each vector with NaN values to equate lengths
        maxNumEl = max(cellfun(@numel, angles_boxplots));
        angles_pad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, angles_boxplots);
        % Convert cell array to matrix and run boxplot
        angles_mat = cell2mat(angles_pad);

        % Generate new names by concatenating the original names and the number of elements
        new_names = cell(1, length(angles_boxplots));
        for i = 1 : length(angles_boxplots)
            new_names{i} = [names{i}, ' (', int2str(numel(angles_boxplots{i})), ' measures)'];
        end

        % Create boxplot with all angles
        boxplot(angles_mat, 'Labels', new_names);

        % Accessing handles to adjust line width
        h = findobj(gca, 'Tag', 'Box');

        for i = 1:length(h)
            set(h(i), 'LineWidth', 1.5);
        end

        % Adjusting font size of labels
        set(gca, 'FontSize', 18);

        % Adding labels and title with improved font size
        ylabel('Phase angle values (φ)', 'FontSize', 16);
        title('Boxplot of phase angles', 'FontSize', 18);

        % Adjusting the plot appearance
        grid on;

    end


end

