
close all
clc

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

% 200 index
index = cell(1, n_essais + 1);

mean_angles = zeros(1, n_essais);
temperatures = zeros(1, n_essais);
a = 0;

% 10 names maximum
names = cell(1, 10);

iteration = 0;

% 200 values maximum
meanFx = zeros(1, length(FullFileNames_all));
meanFy = zeros(1, length(FullFileNames_all));


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
    meanFx(i) = mean(Fx(first:last));
    meanFy(i) = mean(Fy(first:last));

    % Append Fx and Fy to the corresponding benchmark name
    if ~any(strcmp(sample_name, names))

        a = a + 1;
        names{a} = sample_name;
        all_Fx_plot{a} = [];
        all_Fy_plot{a} = [];
        index{a} = cell(1, 100);
        u = 0;

        % Extract the temperature from the sample name using regular expressions
        temp_str = regexp(sample_name, '\d+', 'match');

        % Convert the extracted string to a number and store it in the temperatures array
        if ~isempty(temp_str)
            temperatures(a) = str2double(temp_str{1});
        else
            temperatures(a) = NaN; % Handle cases where no temperature is found
        end

    end

    u = u + 1;
    index{a}{u} = sample_index;

    idx = find(strcmp(names, sample_name));
    all_Fx_plot{idx} = [all_Fx_plot{idx}, meanFx(i)];
    all_Fy_plot{idx} = [all_Fy_plot{idx}, meanFy(i)];

    idx = idx + 1;

    angles_boxplots = cell(1, idx - 1);

    for y = 1 : idx - 1

        % for boxplots
        angles_boxplots{y} = compute_angles(all_Fx_plot{y}, all_Fy_plot{y});
        mean_angles(y) = mean(angles_boxplots{y});

    end

end

% Create the plot
figure;
plot(temperatures, mean_angles, '-o', 'LineWidth', 2, 'MarkerSize', 6);

% Add title and axis labels
title('Mean Phase Angles vs. Temperatures', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Temperature (°C)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Mean Phase Angle (degrees)', 'FontSize', 12, 'FontWeight', 'bold');

% Improve readability
grid on; % Add grid lines
set(gca, 'FontSize', 12); % Set axis tick labels font size
xlim([min(temperatures) max(temperatures)]); % Set x-axis limits
ylim([min(mean_angles)-0.5 max(mean_angles)+0.5]); % Set y-axis limits with some padding

hold on
% Add markers and line style
plot(temperatures, mean_angles, '-o', 'LineWidth', 2, 'MarkerSize', 6, 'MarkerFaceColor', 'blue');

% Display the plot
shg; % Show the figure window (optional, for immediate display)



