function main()

    close all
    clc
    
    % By default we don't plot the boxplots and we don't have samples
    boxplots = false;
    sample = false;

    % Decide if we want to take the sample measures
    prompt = 'Do you want to take the sample measures (see steps) ? (y/n): ';
    user_response = input(prompt, 's');

    if strcmpi(user_response, 'y')

        currentFolder = pwd;
        paramsFilePath = fullfile(currentFolder, 'params.pssettings');
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
    length_sample = 0;
    memory_FullFileNames = 0;
    fullfile_idx = 1;

    if n_essais == 4 && ~input('Do you want to manually select files? (1 for Yes, 0 for No): ') 

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

            % Save the file names to a MAT file
            % save('file_names_data.mat', 'FullFileNames_all', 'number_of_files', 'fullfile_idx');

        end

    end

    % Ask the user if they want to load sample files
    prompt = 'Do you want to load sample files? (y/n): ';
    user_response = input(prompt, 's');

    if strcmpi(user_response, 'y')

        sample = true;

        FullFileNames = usergetfiles(startpath);

        length_sample = length(FullFileNames);

        FullFileNames_all(fullfile_idx : fullfile_idx + length_sample -1) = FullFileNames;      

    end

    % MAKE OUTPUT DIRECTORY
    outputdir=[startpath,'postproc\'];
    if ~exist(outputdir, 'dir')
        mkdir(outputdir)
    end


    if ~iscell(FullFileNames_all)
        error('FullFileNames_all must be a cell ...')
    end


    prompt = 'Do you want to plot the boxplots ? (y/n): ';
    user_response = input(prompt, 's');

    if strcmpi(user_response, 'y')

        boxplots = true;

    end

    % 200 index
    index = cell(1, n_essais + 1);

    % 10 names maximum
    names = cell(1, 10);

    iteration = 0;

    % 200 values maximum
    meanFx = zeros(1, length(FullFileNames_all));
    meanFy = zeros(1, length(FullFileNames_all));

    a = 0;
    euclidean = true;

    % end_full_names = 0;

    % create a new number of benchmarks files
    % count_index_clean = 0;

    u = 0;

    % Initialize cell arrays to store Fx_plot, Fy_plot, and their sizes
    all_Fx_plot = cell(1, 10);
    all_Fy_plot = cell(1, 10);

    all_Fx_plot_clean = cell(1, 10);
    all_Fy_plot_clean = cell(1, 10);

    all_angle_clean = cell(1, 10);
    all_magnitude_clean = cell(1, 10);

    % count_index = 1;

    % READ AND PROCESS FILES
    for i=1:numel(FullFileNames_all)

        if isempty(FullFileNames_all{i})
            
            % end_full_names = i - 1;
            break;  % Exit the loop when encountering the first non-initialized cell

        end

        FullFileName = FullFileNames_all{i}; % acces to i-th filename
        offset = strfind(FullFileName, '.mat')-1; % remove extension from filename
        filename_clean = FullFileName(1:offset);

        %get infos from cleaned filename
        FileName = strsplit(filename_clean,'\');
        FileName = FileName{end};
        infos = strsplit(FileName,'_');
        type = infos{1};
        sample_name = infos{2};
        sample_index = infos{3};

        % load file-i
        load(FullFileName, 'Fx', 'Fy', 'Tinterval');

        %define time array
        t = 0:Tinterval:Tinterval*(numel(Fx)-1);

        %[tmin, tmax] = bounds(t);

        
        %pas sure que le temps soit en seconds, il faut vérifier dans le
        %logiciel du picoscope
        if i == 1

            f10 = figure;
            plot(t,Fy,'r',t,Fx,'b'), xlabel('t(s)'), ylabel('V'), axis tight, legend('Fy','Fx','Location','southwest')
            waitforbuttonpress; p1 = get(gca,'CurrentPoint');
            waitforbuttonpress; p2 = get(gca,'CurrentPoint');
            first = find(t <= p1(1,1)); first = first(end);
            last = find(t <= p2(1,1)); last = last(end);
            close(f10);

        end
        

        %compute mean values
        meanFx(i) = mean(Fx(first:last)); % mode
        meanFy(i) = mean(Fy(first:last));

        % Append Fx and Fy to the corresponding benchmark type
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

        idx = find(strcmp(names, sample_name));
        all_Fx_plot{idx} = [all_Fx_plot{idx}, meanFx(i)];
        all_Fy_plot{idx} = [all_Fy_plot{idx}, meanFy(i)];


    end

    if (sample == false)

        idx = idx + 1;

    end     

    angles_boxplots = cell(1, idx - 1);

    fig1 = figure;

   

    for y = 1 : idx - 1


        [all_Fx_plot_clean{y}, all_Fy_plot_clean{y}, index_clean] = filter_Fx_Fy(all_Fx_plot{y}, all_Fy_plot{y}, index{y});
        % count_index = 1 + number_of_files(idx);

        % Create a new number of benchmarks files
        new_number_of_files(y) = length(index_clean);

        % for boxplots
        angles_boxplots{y} = compute_angles(all_Fx_plot{y}, all_Fy_plot{y});

        if strcmp(names{y}, 'martensiteall') % 'perlite'

            compute_stats(all_Fx_plot{y}, all_Fy_plot{y}, names{y});

        end

        figure(fig1);

        % Get the color for plotting
        color = getColorForIteration(y);

        % Plot data
        plotData(all_Fx_plot_clean{y}, all_Fy_plot_clean{y}, color, names{y}, index_clean, 1);
        plotRegressionAndFilledAreas(all_Fx_plot_clean{y}, all_Fy_plot_clean{y}, color, names(y), iteration);
        iteration = iteration + 1;

        hold on

    end

    xlabel('Resistance Fx in V', 'FontSize', 14);
    ylabel('Reactance Fy in V', 'FontSize', 14);


    new_number_of_files = cumsum(new_number_of_files);

    all_meanFx_clean = zeros(1, new_number_of_files(n_essais));
    all_meanFy_clean = zeros(1, new_number_of_files(n_essais));

    index_Fx = 1;
    index_Fy = 1;

    % When we reach the end of the tab i == length(FullFileNames_all)
    if (sample == true)

            % Not clean yet
            meanFx_sample = all_Fx_plot{idx};
            meanFy_sample = all_Fy_plot{idx};

            % Clean the sample
            [meanFx_sample_clean, meanFy_sample_clean, index_clean] = filter_Fx_Fy(meanFx_sample, meanFy_sample, index{idx});
            
            % Plot data
            plotData(meanFx_sample_clean, meanFy_sample_clean, ...
                'k', 'sample', index_clean, 1);

            Z_sample_clean = meanFx_sample_clean + 1j*meanFy_sample_clean;
            angle_sample_clean = rad2deg(angle(Z_sample_clean));

            for j = 1 : idx - 1
    
                all_meanFx_clean(index_Fx : new_number_of_files(j)) = all_Fx_plot_clean{j};
                index_Fx = 1 + new_number_of_files(j);

                all_meanFy_clean(index_Fy : new_number_of_files(j)) = all_Fy_plot_clean{j};
                index_Fy = 1 + new_number_of_files(j);

                Z_j = all_Fx_plot_clean{j} + 1j*all_Fy_plot_clean{j};
                all_angle_clean{j} = rad2deg(angle(Z_j));  % angles in degrees
                all_magnitude_clean{j} = abs(Z_j);   % magnitudes of each element in Z_j

                Zper = (max(all_magnitude_clean{j}) - min(all_magnitude_clean{j})) / mean(all_magnitude_clean{j}) * 100;
                angleper = (max(all_angle_clean{j}) - min(all_angle_clean{j})) / mean(all_angle_clean{j}) * 100;

            end


            % Initialize counter for members included for each j
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


            % Calculate distances for each sample separately
            distances = zeros(size(meanFx_sample_clean, 2), size(all_meanFx_clean, 2));

            % Define the number of neighbors to consider per sample
            k = 5;
            
            count = zeros(idx-1, numel(meanFx_sample_clean));

            count_angle = zeros(idx-1, numel(meanFx_sample_clean));

            real_sorted_distances = zeros(numel(meanFx_sample_clean), length(all_meanFx_clean));
            real_sorted_indices = zeros(numel(meanFx_sample_clean), length(all_meanFx_clean));

            distances_angle = zeros(size(meanFx_sample_clean, 2), size(all_meanFx_clean, 2));

            real_sorted_distances_angle = zeros(numel(meanFx_sample_clean), length(all_meanFx_clean));
            real_sorted_indices_angle = zeros(numel(meanFx_sample_clean), length(all_meanFx_clean));

            Z_sample = zeros(1, numel(meanFx_sample_clean));
            angle_sample = zeros(1, numel(meanFx_sample_clean));

            for i = 1:numel(meanFx_sample_clean)

                distances(i, :) = sqrt((meanFx_sample_clean(i) - all_meanFx_clean).^2 + (meanFy_sample_clean(i) - all_meanFy_clean).^2);
                [sorted_distances, sorted_indices] = sort(distances(i, :));
                real_sorted_distances(i, :) = sorted_distances;
                real_sorted_indices(i, :) = sorted_indices;

                % Count occurrences of each type among the k nearest neighbors

                start_columns_all_plot_clean = 1;
                end_columns_all_plot_clean = 0;

                % get Z and the angles for each point
                Z = all_meanFx_clean + 1j*all_meanFy_clean;
                angles = rad2deg(angle(Z));

                Z_sample(i) = meanFx_sample_clean(i) + 1j*meanFy_sample_clean(i);
                angle_sample(i) = rad2deg(angle(Z_sample(i)));

                distances_angle(i, :) = abs(angle_sample(i) - angles);

                [sorted_distances_angle, sorted_indices_angle] = sort(distances_angle(i, :));

                real_sorted_distances_angle(i, :) = sorted_distances_angle;
                real_sorted_indices_angle(i, :) = sorted_indices_angle;

                % Count occurrences of each type among the k nearest neighbors


                for h = 1 : idx - 1

                    end_columns_all_plot_clean = start_columns_all_plot_clean + length(all_Fx_plot_clean{h}) - 1;
                    count_angle(h, i) = sum(ismember(real_sorted_indices_angle(i, 1:k), start_columns_all_plot_clean : end_columns_all_plot_clean));
                    count(h, i) = sum(ismember(real_sorted_indices(i, 1:k), start_columns_all_plot_clean : end_columns_all_plot_clean));
                    start_columns_all_plot_clean = start_columns_all_plot_clean + length(all_Fx_plot_clean{h});

                end


                % Compute percentages
                total_count = sum(sum(count, 2));
                percentages = sum(count, 2) ./ total_count * 100;

                % Compute percentages
                total_count_angle = sum(sum(count_angle, 2));
                percentages_angle = sum(count_angle, 2) ./ total_count_angle * 100;


            end

            % Display results
            fprintf('Percentage of 5 closest neighbors by angle for %s :\n', names{idx});

            for i = 1 : idx - 1

                fprintf('%s: %.2f%%\n', names{i}, mean(percentages_angle(i)));

            end

            if euclidean

                fprintf('Percentage of 5 closest neighbors by euclidean distance for %s :\n', names{idx});

                for i = 1 : idx - 1

                    fprintf('%s: %.2f%%\n', names{i}, mean(percentages(i)));

                end

            end








    end


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

    if (n_essais == 1)

        FullFileNames =[outputdir, type, '_', sample_name];

    else

        FullFileNames =[outputdir, 'map'];

    end

    % saveas(gcf,FullFileNames,'emf');
    % saveas(gcf,FullFileNames,'tiffn')


end

