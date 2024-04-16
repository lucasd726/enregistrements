function donnees()

    close all

    % Define directories
    directory_perlite = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\perlite\';
    directory_martensite = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\martensite\';
    directory_WEL = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\WEL\';
    directory_rail = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\rail\';
    directory_rugosite = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\rugosite\';
    directory_perlite_v2 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\perlite_v2\';
    directory_perlite_v3 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\perlite_v3\';
    directory_martensite_v2 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\martensite_v2\';
    directory_martensite_v3 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\martensite_v3\';
    directory_martensite_v4 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\martensite_v4\';

    directory_rugosite_v2 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\rugosite_v2\';
    directory_WEL_v2 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\WEL_v2\';
    directory_perlite_v4 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\perlite_v4\';
    directory_sideWEL_v2 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\WEL_v2\';

    directory_WEL_v3 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\WEL_v3\';
    directory_sideWEL_v3 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\WEL_v3\';

    directory_W3 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\W3\';
    directory_perlite_v5 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\perlite_v5\';

    directory_amplitude = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\amplitude\';
    directory_triboring_v1 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\triboring_v1\';

    directory_incertitude_perlite = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\incertitude_perlite\';
    directory_incertitude_martensite = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\incertitude_martensite\';
    directory_incertitude_triboring3 = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\incertitude_triboring3\';
    directory_incertitude_WEL = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\incertitude_WEL\';

    index_perlite = {'1', '2', '3', '4', '5', '6', '7', '8', '9'};
    index_martensite = {'1', '2', '3', '4', '5', '6', '7', '8', '9'};
    index_WEL = {'3', '4', '5', '10', '11', '12', '17', '18', '19'};
    index_sideWEL = {'1', '2', '6', '7', '8', '9', '13', '14', '15', '16', '20', '21', '22', '23', '27', '28'};
    index_rail = {'1', '2', '3', '4', '5', '6', '7', '8', '9'};
    index_rugosite = {'1', '2', '3', '4', '5', '6', '7', '8', '9'};
    index_perlite_v2 = {'1', '2', '3', '4', '5', '6', '7', '8', '9'};
    index_perlite_v3 = {'1', '2', '3', '4', '5', '6', '7', '8', '9'};
    index_martensite_v2 = {'1', '2', '3', '4', '5', '6', '7', '8', '9'};
    index_rugosite_v2 = {'1', '2', '3', '4', '5', '6', '7', '8', '9'};
    index_WEL_v2 = {'3', '4', '5', '10', '11', '12', '17', '18', '19'};
    index_perlite_v4 = {'1', '2', '3', '4', '5', '6', '7', '8', '9'};
    index_sideWEL_v2 = {'1', '2', '6', '7', '8', '9', '13', '14', '15', '16', '20', '21', '22', '23', '27', '28'};

    index_WEL_v3 = {'3', '4', '5', '10', '11', '12', '17', '18', '19'};
    index_sideWEL_v3 = {'1', '2', '6', '7', '8', '9', '13', '14', '15', '16', '20', '21', '22', '23', '27', '28'};

    index_W3 = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', ...
        '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30'};

    index = {'1', '2', '3', '4', '5', '6', '7', '8', '9'};
    index_30 = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', ...
        '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30'};
    index_10 = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10'};

    

    close all
    clear all
    clc

    number_of_files = zeros(1,5);
    user = getenv('username');
    startpath = ['C:\Users\',user,'\Desktop\PRI\enregistrements\'];
    n_essais = 3;
    FullFileNames_all = {};
    for k = 1:n_essais
        FullFileNames = usergetfiles(startpath);
        FullFileNames_all = [FullFileNames_all, FullFileNames];

        % Cumulatively sum the lengths of FullFileNames
        number_of_files(k) = length(FullFileNames_all);

    end

    % MAKE OUTPUT DIRECTORY
    outputdir=[startpath,'postproc\'];
    if ~exist(outputdir, 'dir')
        mkdir(outputdir)
    end

    f1 = figure, plot(0,0);

    a = 0;
    index = cell(1, length(FullFileNames_all)); 

    iteration = 0;
    meanFx = zeros(1, length(FullFileNames_all));
    meanFy = zeros(1, length(FullFileNames_all));

    % READ AND PROCESS FILES
    for i=1:numel(FullFileNames_all)

        FullFileName = FullFileNames_all{i}; %acces to i-th filename
        offset = strfind(FullFileName, '.mat')-1;% remove extension from filename
        filename_clean = FullFileName(1:offset);

        %get infos from cleaned filename
        FileName = strsplit(filename_clean,'\');
        FileName = FileName{end};
        infos = strsplit(FileName,'_');
        type = infos{1};
        sample_name = infos{2};
        sample_index = infos{3};

        index{i} = sample_index;

        % load file-i
        load(FullFileName)


        %define time array
        t = 0:Tinterval:Tinterval*(numel(Fx)-1);

        [tmin, tmax] = bounds(t);

        f10 = figure;
        plot(t,Fy,'r',t,Fx,'b'), xlabel('t(s)'), ylabel('V'), axis tight, legend('Fy','Fx','Location','southwest')
        %pas sure que le temps soit en seconds, il faut vérifier dans le
        %logiciel du picoscope
        if i == 1
            waitforbuttonpress; p1 = get(gca,'CurrentPoint');
            waitforbuttonpress; p2= get(gca,'CurrentPoint');
            first = find(t <= p1(1,1)); first = first(end);
            last = find(t <= p2(1,1)); last = last(end);
        end
        close(f10)

        %compute mean values
        meanFx(i) = mean(Fx(first:last));
        meanFy(i) = mean(Fy(first:last));

        if (sum(i == number_of_files) == 1)

            a = a + 1;

            % Extract Fx and Fy variables
            Fx_variable_name = sprintf('meanFx_%s_%s', type, sample_name);
            Fy_variable_name = sprintf('meanFy_%s_%s', type, sample_name);

            % Get the color for plotting
            color = getColorForIteration(a);

            if (a == 1)

                % Assign Fx and Fy variables automatically
                eval([Fx_variable_name ' = meanFx(1:number_of_files(a));']);
                eval([Fy_variable_name ' = meanFy(1:number_of_files(a));']);

            else
                
                % Assign Fx and Fy variables automatically
                eval([Fx_variable_name ' = meanFx(number_of_files(a-1):number_of_files(a));']);
                eval([Fy_variable_name ' = meanFy(number_of_files(a-1):number_of_files(a));']);

            end
            

            % Plot data
            plotData(eval(Fx_variable_name), eval(Fy_variable_name), color, sample_name, index);
            plotRegressionAndFilledAreas(eval(Fx_variable_name), eval(Fy_variable_name), color, [type, ' ', sample_name], iteration);
            iteration = iteration + 1;

            index = {};

            hold on

        end


    end




    FullFileNames =[outputdir,type,'_',sample_name];
    saveas(gcf,FullFileNames,'emf');
    saveas(gcf,FullFileNames,'tiffn')

    % Load data
    % [meanFx_perlite, meanFy_perlite] = loadMeanData(directory_perlite, 'test_FxFy_perlite', 9, index_perlite);
    % [meanFx_martensite, meanFy_martensite] = loadMeanData(directory_martensite, 'test_FxFy_martensite', 9, index_martensite);
    % [meanFx_WEL, meanFy_WEL] = loadMeanData(directory_WEL, 'test_FxFy_WEL', 9, index_WEL);
    % [meanFx_sideWEL, meanFy_sideWEL] = loadMeanData(directory_WEL, 'test_FxFy_WEL', size(index_sideWEL, 2), index_sideWEL);
    % [meanFx_rail, meanFy_rail] = loadMeanData(directory_rail, 'test_FxFy_rail', 9, index_rail);
    % [meanFx_rugosite, meanFy_rugosite] = loadMeanData(directory_rugosite, 'test_FxFy_rugosite', 9, index_rugosite);
    % [meanFx_perlite_v2, meanFy_perlite_v2] = loadMeanData(directory_perlite_v2, 'perlite_v2', 9, index_perlite);
    % [meanFx_perlite_v3, meanFy_perlite_v3] = loadMeanData(directory_perlite_v3, 'perlite_v3', 9, index_perlite);
    % [meanFx_martensite_v2, meanFy_martensite_v2] = loadMeanData(directory_martensite_v2, 'martensite_v2', 9, index_martensite);
    % [meanFx_martensite_v3, meanFy_martensite_v3] = loadMeanData(directory_martensite_v3, 'martensite_v3', 9, index_martensite);
    % [meanFx_martensite_v4, meanFy_martensite_v4] = loadMeanData(directory_martensite_v4, 'martensite_v4', 9, index);
    % 
    % [meanFx_rugosite_v2, meanFy_rugosite_v2] = loadMeanData(directory_rugosite_v2, 'rugosite_v2', 9, index_rugosite_v2);
    % [meanFx_WEL_v2, meanFy_WEL_v2] = loadMeanData(directory_WEL_v2, 'WEL_v2', size(index_WEL_v2, 2), index_WEL_v2);
    % [meanFx_perlite_v4, meanFy_perlite_v4] = loadMeanData(directory_perlite_v4, 'perlite_v4', 9, index_perlite);
    % [meanFx_sideWEL_v2, meanFy_sideWEL_v2] = loadMeanData(directory_WEL_v2, 'WEL_v2', size(index_sideWEL_v2, 2), index_sideWEL_v2);
    % 
    % [meanFx_WEL_v3, meanFy_WEL_v3] = loadMeanData(directory_WEL_v3, 'WEL_v3', 9, index_WEL_v3);
    % [meanFx_sideWEL_v3, meanFy_sideWEL_v3] = loadMeanData(directory_WEL_v3, 'WEL_v3', size(index_sideWEL_v3, 2), index_sideWEL_v3);
    % 
    % [meanFx_W3, meanFy_W3] = loadMeanData(directory_W3, 'W3', size(index_W3, 2), index_W3);
    % [meanFx_perlite_v5, meanFy_perlite_v5] = loadMeanData(directory_perlite_v5, 'perlite_v5', 9, index_perlite);
    % 
    % [meanFx_amplitude, meanFy_amplitude] = loadMeanData(directory_amplitude, 'amplitude', 9, index);
    % [meanFx_triboring_v1, meanFy_triboring_v1] = loadMeanData(directory_triboring_v1, 'triboring_v1', 9, index);
    % 
    % 
    % [meanFx_incertitude_perlite, meanFy_incertitude_perlite] = loadMeanData(directory_incertitude_perlite, 'incertitude_perlite', size(index_30, 2), index_30);
    % [meanFx_incertitude_martensite, meanFy_incertitude_martensite] = loadMeanData(directory_incertitude_martensite, 'incertitude_martensite', size(index_30, 2), index_30);
    % [meanFx_incertitude_triboring3, meanFy_incertitude_triboring3] = loadMeanData(directory_incertitude_triboring3, 'incertitude_triboring3', size(index_30, 2), index_30);
    % [meanFx_incertitude_WEL, meanFy_incertitude_WEL] = loadMeanData(directory_incertitude_WEL, 'incertitude_WEL', size(index_30, 2), index_30);

    % Set switches to enable/disable plotting for each set

    plot_perlite = false; % true
    plot_perlite_v2 = false;
    plot_perlite_v3 = false;
    plot_perlite_v4 = false;
    plot_perlite_v5 = false;
    plot_rail = false;
    plot_rugosite = false;
    plot_rugosite_v2 = false;

    plot_martensite = false; % false
    plot_martensite_v2 = false;
    plot_martensite_v3 = false;
    plot_martensite_v4 = false;

    plot_WEL = false;
    plot_WEL_v2 = false;
    plot_WEL_v3 = false;

    plot_sideWEL = false;
    plot_sideWEL_v2 = false;
    plot_sideWEL_v3 = false;

    plot_W3 = false;

    plot_amplitude = false;
    plot_triboring_v1 = false;

    plot_incertitude_perlite = false;
    plot_incertitude_martensite = false;
    plot_incertitude_triboring3 = false;
    plot_incertitude_WEL = false;

    plot_all_boxplots = false;

    STATS = true;

    plot_sample = true;
    plot_zone = true;
    euclidean = true;

    % Iterations
    iteration = 0;

    figure;
    % Get the handle of the first figure
    fig1 = gcf;

    % Plot data based on switches
    if plot_perlite
        iteration = iteration + 1;
        plotData(meanFx_perlite, meanFy_perlite, 'b', 'p', index_perlite);
        plotRegressionAndFilledAreas(meanFx_perlite, meanFy_perlite, 'b', 'R260 Perlite v1', iteration);
    end

    if plot_perlite_v2
        iteration = iteration + 1;
        plotData(meanFx_perlite_v2, meanFy_perlite_v2, 'r', 'p_{v2}', index_perlite);
        plotRegressionAndFilledAreas(meanFx_perlite_v2, meanFy_perlite_v2, 'r', 'R260 Perlite v2', iteration);
    end

    if plot_perlite_v3
        iteration = iteration + 1;
        plotData(meanFx_perlite_v3, meanFy_perlite_v3, 'k', 'p_{v3}', index_perlite);
        plotRegressionAndFilledAreas(meanFx_perlite_v3, meanFy_perlite_v3, 'k', 'R260 Perlite v3', iteration);
    end

    if plot_perlite_v4
        iteration = iteration + 1;
        plotData(meanFx_perlite_v4, meanFy_perlite_v4, 'c', 'p_{v4}', index_perlite);
        plotRegressionAndFilledAreas(meanFx_perlite_v4, meanFy_perlite_v4, 'c', 'R260 Perlite v4', iteration);
    end

    if plot_perlite_v5
        iteration = iteration + 1;
        plotData(meanFx_perlite_v5, meanFy_perlite_v5, 'g', 'p', index_perlite);
        plotRegressionAndFilledAreas(meanFx_perlite_v5, meanFy_perlite_v5, 'g', 'R260 Perlite v5', iteration);
    end

    if plot_rail
        iteration = iteration + 1;
        plotData(meanFx_rail, meanFy_rail, [0 0.5 0], 'r', index_rail);
        plotRegressionAndFilledAreas(meanFx_rail, meanFy_rail, [0 0.5 0], 'R260 Rail', iteration);
    end

    if plot_rugosite
        iteration = iteration + 1;
        plotData(meanFx_rugosite, meanFy_rugosite, [0 0 0.5], 'r', index_rugosite);
        plotRegressionAndFilledAreas(meanFx_rugosite, meanFy_rugosite, [0 0 0.5], 'R260 Rugosite', iteration);
    end

    if plot_rugosite_v2
        iteration = iteration + 1;
        plotData(meanFx_rugosite_v2, meanFy_rugosite_v2, [0 0 0.5], 'r', index_rugosite_v2);
        plotRegressionAndFilledAreas(meanFx_rugosite_v2, meanFy_rugosite_v2, [0 0 0.5], 'R260 Rugosite v2', iteration);
    end

    if plot_martensite
        iteration = iteration + 1;
        plotData(meanFx_martensite, meanFy_martensite, 'g', 'm', index_martensite);
        plotRegressionAndFilledAreas(meanFx_martensite, meanFy_martensite, 'g', 'Martensite', iteration);
    end

    if plot_martensite_v2
        iteration = iteration + 1;
        plotData(meanFx_martensite_v2, meanFy_martensite_v2, 'k', 'm_{v2}', index_martensite);
        plotRegressionAndFilledAreas(meanFx_martensite_v2, meanFy_martensite_v2, 'k', 'Martensite v2', iteration);
    end

    if plot_martensite_v3
        iteration = iteration + 1;
        plotData(meanFx_martensite_v3, meanFy_martensite_v3, 'r', 'm_{v3}', index_martensite);
        plotRegressionAndFilledAreas(meanFx_martensite_v3, meanFy_martensite_v3, 'r', 'Martensite v3', iteration);
    end

    if plot_martensite_v4
        iteration = iteration + 1;
        plotData(meanFx_martensite_v4, meanFy_martensite_v4, 'b', 'm_{v4}', index_martensite);
        plotRegressionAndFilledAreas(meanFx_martensite_v4, meanFy_martensite_v4, 'b', 'Martensite v4', iteration);
    end

    if plot_WEL
        iteration = iteration + 1;
        plotData(meanFx_WEL, meanFy_WEL, 'r', 'W', index_WEL);
        plotRegressionAndFilledAreas(meanFx_WEL, meanFy_WEL, 'r', 'WEL', iteration);
    end

    if plot_WEL_v2
        iteration = iteration + 1;
        plotData(meanFx_WEL_v2, meanFy_WEL_v2, 'r', 'W', index_WEL_v2);
        plotRegressionAndFilledAreas(meanFx_WEL_v2, meanFy_WEL_v2, 'r', 'WEL v2', iteration);
    end

    if plot_WEL_v3
        iteration = iteration + 1;
        plotData(meanFx_WEL_v3, meanFy_WEL_v3, 'r', 'W', index_WEL_v3);
        plotRegressionAndFilledAreas(meanFx_WEL_v3, meanFy_WEL_v3, 'r', 'WEL v3', iteration);
    end

    if plot_sideWEL
        iteration = iteration + 1;
        plotData(meanFx_sideWEL, meanFy_sideWEL, 'r', 'sW', index_sideWEL);
        plotRegressionAndFilledAreas(meanFx_sideWEL, meanFy_sideWEL, 'r', 'sideWEL', iteration);
    end

    if plot_sideWEL_v2
        iteration = iteration + 1;
        plotData(meanFx_sideWEL_v2, meanFy_sideWEL_v2, 'b', 'sW_{v2}', index_sideWEL_v2);
        plotRegressionAndFilledAreas(meanFx_sideWEL_v2, meanFy_sideWEL_v2, 'b', 'sideWEL v2', iteration);
    end

    if plot_sideWEL_v3
        iteration = iteration + 1;
        plotData(meanFx_sideWEL_v3, meanFy_sideWEL_v3, 'g', 'sW_{v3}', index_sideWEL_v3);
        plotRegressionAndFilledAreas(meanFx_sideWEL_v3, meanFy_sideWEL_v3, 'g', 'sideWEL v3', iteration);
    end

    if plot_W3
        iteration = iteration + 1;
        plotData(meanFx_W3, meanFy_W3, 'g', 'W3', index_W3);
        plotRegressionAndFilledAreas(meanFx_W3, meanFy_W3, 'g', 'W3', iteration);
    end

    if plot_amplitude
        iteration = iteration + 1;
        plotData(meanFx_amplitude, meanFy_amplitude, 'g', 'a', index);
        plotRegressionAndFilledAreas(meanFx_amplitude, meanFy_amplitude, 'g', 'a', iteration);
    end

    if plot_triboring_v1
        iteration = iteration + 1;
        plotData(meanFx_triboring_v1, meanFy_triboring_v1, 'g', 't', index);
        plotRegressionAndFilledAreas(meanFx_triboring_v1, meanFy_triboring_v1, 'g', 'Triboring v1', iteration);
    end

    if plot_incertitude_perlite
        iteration = iteration + 1;
        plotData(meanFx_incertitude_perlite, meanFy_incertitude_perlite, 'g', 't', index_30);
        plotRegressionAndFilledAreas(meanFx_incertitude_perlite, meanFy_incertitude_perlite, 'g', 'Incertitude perlite', iteration);

        if STATS

            compute_stats(meanFx_incertitude_perlite, meanFy_incertitude_perlite, 'Perlite');
 
        end

    end
    
    if plot_incertitude_martensite

        iteration = iteration + 1;
        plotData(meanFx_incertitude_martensite, meanFy_incertitude_martensite, 'g', 't', index_30);
        plotRegressionAndFilledAreas(meanFx_incertitude_martensite, meanFy_incertitude_martensite, 'g', 'Incertitude martensite', iteration);

        if STATS

            compute_stats(meanFx_incertitude_martensite, meanFy_incertitude_martensite, 'Martensite');
 
        end

    end

    if plot_incertitude_triboring3

        iteration = iteration + 1;
        % plotData(meanFx_incertitude_martensite, meanFy_incertitude_martensite, 'g', 't', index_30);
        plotRegressionAndFilledAreas(meanFx_incertitude_triboring3, meanFy_incertitude_triboring3, 'g', 'Incertitude triboring3', iteration);

        if STATS

            compute_stats(meanFx_incertitude_triboring3, meanFy_incertitude_triboring3, 'Triboring3');
 
        end

    end


    if plot_incertitude_WEL

        iteration = iteration + 1;
        plotData(meanFx_incertitude_WEL, meanFy_incertitude_WEL, 'b', 'WEL', index_30);
        plotRegressionAndFilledAreas(meanFx_incertitude_WEL, meanFy_incertitude_WEL, 'b', 'Incertitude WEL', iteration);

        if STATS

            compute_stats(meanFx_incertitude_WEL, meanFy_incertitude_WEL, 'WEL');
 
        end

    end

    figure(fig1);  % Switch to the first figure using its handle
    % Label the axes with larger font size
    xlabel('Fx (V)', 'FontSize', 18);
    ylabel('Fy (V)', 'FontSize', 18);
    grid on;

    if plot_all_boxplots
    
        angles_incertitude_perlite = compute_angles(meanFx_incertitude_perlite, meanFy_incertitude_perlite);
        angles_incertitude_martensite = compute_angles(meanFx_incertitude_martensite, meanFy_incertitude_martensite);
        angles_incertitude_triboring3 = compute_angles(meanFx_incertitude_triboring3, meanFy_incertitude_triboring3);
        angles_incertitude_WEL = compute_angles(meanFx_incertitude_WEL, meanFy_incertitude_WEL);
    
        figure;
    
        % Create boxplot with all angles
        boxplot([angles_incertitude_perlite' angles_incertitude_martensite' angles_incertitude_triboring3' angles_incertitude_WEL'], ...
            'Labels', {'Perlite (30 measures)', 'Martensite (30 measures)', 'Triboring track 3 (30 measures)', 'WEL (30 measures)'});
    
        % Accessing handles to adjust line width
        h = findobj(gca, 'Tag', 'Box');
        for i = 1:length(h)
            set(h(i), 'LineWidth', 1.5);
        end
    
        % Adjusting font size of labels
        set(gca, 'FontSize', 16);
    
        % Adding labels and title with improved font size
        ylabel('Phase angle values', 'FontSize', 16);
        title('Boxplot of phase angles', 'FontSize', 18);
    
        % Adjusting the plot appearance
        grid on;

    end

    % Name for the graph with larger font size
    % title('R260 Triboring VS R260 Rugosite', 'FontSize', 20);

    
    directory_sample = '\Users\lucas\Desktop\PRI\enregistrements\Essais_perlite_ref\sample\';
    [meanFx_sample, meanFy_sample] = loadMeanData(directory_sample, 'sample', 1 , index_10);

    % Concatenate data for perlite, martensite, and WEL
    % perlite_meanFx_combined = [meanFx_perlite_v2, meanFx_perlite_v3, meanFx_perlite_v4, meanFx_perlite_v5, meanFx_rail];
    % perlite_meanFy_combined = [meanFy_perlite_v2, meanFy_perlite_v3, meanFy_perlite_v4, meanFy_perlite_v5, meanFy_rail];

    perlite_meanFx_combined = [meanFx_incertitude_perlite];
    perlite_meanFy_combined = [meanFy_incertitude_perlite];

    % martensite_meanFx_combined = [meanFx_martensite, meanFx_martensite_v2, meanFx_martensite_v3];
    % martensite_meanFy_combined = [meanFy_martensite, meanFy_martensite_v2, meanFy_martensite_v3];

    martensite_meanFx_combined = [meanFx_incertitude_martensite];
    martensite_meanFy_combined = [meanFy_incertitude_martensite];
    
    % WEL_meanFx_combined = [meanFx_WEL, meanFx_WEL_v2, meanFx_WEL_v3];
    % WEL_meanFy_combined = [meanFy_WEL, meanFy_WEL_v2, meanFy_WEL_v3]; 

    WEL_meanFx_combined = [meanFx_incertitude_WEL];%, meanFx_WEL_v2, meanFx_WEL_v3];
    WEL_meanFy_combined = [meanFy_incertitude_WEL];%, meanFy_WEL_v2, meanFy_WEL_v3]; 

    triboring_meanFx_combined = [meanFx_incertitude_triboring3];
    triboring_meanFy_combined = [meanFy_incertitude_triboring3]; 



    if plot_zone

        figure;



        [filtered_perlite_meanFx_combined, filtered_perlite_meanFy_combined] = filter_Fx_Fy(perlite_meanFx_combined, perlite_meanFy_combined);

        plotRegressionAndFilledAreas(filtered_perlite_meanFx_combined, filtered_perlite_meanFy_combined, 'g', 'Perlite', iteration);


        plotData(filtered_perlite_meanFx_combined, filtered_perlite_meanFy_combined, 'g', 'Perlite', 1:length(filtered_perlite_meanFx_combined));
        

        iteration = iteration + 1;


        [filtered_martensite_meanFx_combined, filtered_martensite_meanFy_combined] = filter_Fx_Fy(martensite_meanFx_combined, martensite_meanFy_combined);

        plotRegressionAndFilledAreas(filtered_martensite_meanFx_combined, filtered_martensite_meanFy_combined, 'b', 'Martensite', iteration);
        
        
        plotData(filtered_martensite_meanFx_combined, filtered_martensite_meanFy_combined, 'b', 'Martensite', 1:length(filtered_martensite_meanFx_combined));
        
        iteration = iteration + 1;

        [filtered_WEL_meanFx_combined, filtered_WEL_meanFy_combined] = filter_Fx_Fy(WEL_meanFx_combined, WEL_meanFy_combined);

        plotRegressionAndFilledAreas(filtered_WEL_meanFx_combined, filtered_WEL_meanFy_combined, 'r', 'WEL', iteration);
        

        plotData(filtered_WEL_meanFx_combined, filtered_WEL_meanFy_combined, 'r', 'WEL', 1:length(filtered_WEL_meanFx_combined));

        iteration = iteration + 1;

        [filtered_triboring_meanFx_combined, filtered_triboring_meanFy_combined] = filter_Fx_Fy(triboring_meanFx_combined, triboring_meanFy_combined);

        plotRegressionAndFilledAreas(filtered_triboring_meanFx_combined, filtered_triboring_meanFy_combined, 'k', 'Triboring', iteration);

        plotData(filtered_triboring_meanFx_combined, filtered_triboring_meanFy_combined, 'k', 'Triboring', 1:length(filtered_triboring_meanFx_combined));


        iteration = iteration + 1;

        xlabel('Fx (V)', 'FontSize', 18);
        ylabel('Fy (V)', 'FontSize', 18);
        grid on;
        
    end

    if plot_sample

        plotData(meanFx_sample, meanFy_sample, 'k', 'sample', index_10);

    end

    perlite_meanFx_combined = filtered_perlite_meanFx_combined;
    martensite_meanFx_combined = filtered_martensite_meanFx_combined;
    triboring_meanFx_combined = filtered_triboring_meanFx_combined;
    WEL_meanFx_combined = filtered_WEL_meanFx_combined;

    perlite_meanFy_combined = filtered_perlite_meanFy_combined;
    martensite_meanFy_combined = filtered_martensite_meanFy_combined;
    triboring_meanFy_combined = filtered_triboring_meanFy_combined;
    WEL_meanFy_combined = filtered_WEL_meanFy_combined;

    % Concatenate all loaded data into single arrays
    all_meanFx = [perlite_meanFx_combined, martensite_meanFx_combined, triboring_meanFx_combined, WEL_meanFx_combined];
    all_meanFy = [perlite_meanFy_combined, martensite_meanFy_combined, triboring_meanFy_combined, WEL_meanFy_combined];

    % Calculate distances for each sample separately
    distances = zeros(size(meanFx_sample, 2), size(all_meanFx, 2));

    % Define the number of neighbors to consider per sample
    k = 10;

    perlite_count = zeros(1, numel(meanFx_sample));
    martensite_count = zeros(1, numel(meanFx_sample));
    triboring_count = zeros(1, numel(meanFx_sample));
    WEL_count = zeros(1, numel(meanFx_sample));

    perlite_count_angle = zeros(1, numel(meanFx_sample));
    martensite_count_angle = zeros(1, numel(meanFx_sample));
    triboring_count_angle = zeros(1, numel(meanFx_sample));
    WEL_count_angle = zeros(1, numel(meanFx_sample));


    for i = 1:numel(meanFx_sample)

        if euclidean

            distances(i, :) = sqrt((meanFx_sample(i) - all_meanFx).^2 + (meanFy_sample(i) - all_meanFy).^2);
            [sorted_distances, sorted_indices] = sort(distances(i, :));
            real_sorted_distances(i, :) = sorted_distances;
            real_sorted_indices(i, :) = sorted_indices;
    
            % Count occurrences of each type among the k nearest neighbors
            perlite_count(i) = sum(ismember(real_sorted_indices(i, 1:k), 1:size(perlite_meanFx_combined, 2)));
            martensite_count(i) = sum(ismember(real_sorted_indices(i, 1:k), (size(perlite_meanFx_combined, 2)+1):(size(perlite_meanFx_combined, 2) + size(martensite_meanFx_combined, 2))));
            triboring_count(i) = sum(ismember(real_sorted_indices(i, 1:k), (size(perlite_meanFx_combined, 2) + size(martensite_meanFx_combined, 2) + 1):...
               (size(perlite_meanFx_combined, 2) + size(martensite_meanFx_combined, 2) + size(triboring_meanFx_combined, 2)) ));
            WEL_count(i) = sum(ismember(real_sorted_indices(i, 1:k), (size(perlite_meanFx_combined, 2) + size(martensite_meanFx_combined, 2) + size(triboring_meanFx_combined, 2) + 1):size(distances,2)));
    
            % Compute percentages
            total_count = perlite_count + martensite_count + triboring_count + WEL_count;
            perlite_percentage = (perlite_count ./ total_count) * 100;
            martensite_percentage = (martensite_count ./ total_count) * 100;
            triboring_percentage = (triboring_count ./ total_count) * 100;
            WEL_percentage = (WEL_count ./ total_count) * 100;

        end

        % get Z and the angles for each point 
        Z = all_meanFx + 1j*all_meanFy;
        angles = angle(rad2deg(Z));

        Z_sample(i) = meanFx_sample(i) + 1j*meanFy_sample(i);
        angle_sample(i) = angle(rad2deg(Z_sample(i)));

        distances_angle(i, :) = abs(angle_sample(i) - angles);               
       
        [sorted_distances_angle, sorted_indices_angle] = sort(distances_angle(i, :));

        real_sorted_distances_angle(i, :) = sorted_distances_angle;
        real_sorted_indices_angle(i, :) = sorted_indices_angle;

        % Count occurrences of each type among the k nearest neighbors
        perlite_count_angle(i) = sum(ismember(real_sorted_indices_angle(i, 1:k), 1:size(perlite_meanFx_combined, 2)));
        martensite_count_angle(i) = sum(ismember(real_sorted_indices_angle(i, 1:k), (size(perlite_meanFx_combined, 2)+1):(size(perlite_meanFx_combined, 2) + size(martensite_meanFx_combined, 2))));
        triboring_count_angle(i) = sum(ismember(real_sorted_indices_angle(i, 1:k), (size(perlite_meanFx_combined, 2) + size(martensite_meanFx_combined, 2) + 1):...
               (size(perlite_meanFx_combined, 2) + size(martensite_meanFx_combined, 2) + size(triboring_meanFx_combined, 2)) ));
        WEL_count_angle(i) = sum(ismember(real_sorted_indices_angle(i, 1:k), (size(perlite_meanFx_combined, 2) + size(martensite_meanFx_combined, 2) + size(triboring_meanFx_combined, 2) + 1):size(distances_angle,2)));


        % Compute percentages
        total_count_angle = perlite_count_angle + martensite_count_angle + triboring_count_angle + WEL_count_angle;
        perlite_percentage_angle = (perlite_count_angle ./ total_count_angle) * 100;
        martensite_percentage_angle = (martensite_count_angle ./ total_count_angle) * 100;
        triboring_percentage_angle = (triboring_count_angle ./ total_count_angle) * 100;
        WEL_percentage_angle = (WEL_count_angle ./ total_count_angle) * 100;


    end


    % Display results
    fprintf('Percentage of 100 closest neighbors by angle :\n');
    fprintf('Perlite: %.2f%%\n', mean(perlite_percentage_angle));
    fprintf('Martensite: %.2f%%\n', mean(martensite_percentage_angle));
    fprintf('Triboring: %.2f%%\n', mean(triboring_percentage_angle));
    fprintf('WEL: %.2f%%\n', mean(WEL_percentage_angle));

    if euclidean

        fprintf('Percentage of 100 closest neighbors by euclidean distance :\n');
        fprintf('Perlite: %.2f%%\n', mean(perlite_percentage));
        fprintf('Martensite: %.2f%%\n', mean(martensite_percentage));
        fprintf('Triboring: %.2f%%\n', mean(triboring_percentage));
        fprintf('WEL: %.2f%%\n', mean(WEL_percentage));

    end
    
end

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

function plotData(meanFx, meanFy, color, label, index)
    % Plot mean points
    plot(meanFx, meanFy, 'o', 'Color', color);
    hold on;
    % Add labels
    for i = 1:length(meanFx)
        text(meanFx(i), meanFy(i), ['  ' label index{1, i+1}], 'Color', color);
    end
end

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

function [coefficients_low, coefficients_high] = performLinearRegression(meanFx, meanFy)
    % Perform linear regression for low and high slopes

    % get Z and the angles for each point 
    Z = meanFx + 1j*meanFy;
    angles = angle(Z);

    [~, pos_min_angle] = min(rad2deg(angles));
    [~, pos_max_angle] = max(rad2deg(angles));

    % Low slope
    coefficients_low = polyfit([0, meanFx(pos_min_angle)], [0, meanFy(pos_min_angle)], 1);

    % High slope
    coefficients_high = polyfit([0, meanFx(pos_max_angle)], [0, meanFy(pos_max_angle)], 1);

end

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

function plotFilledAreas(meanFx, coefficients_low, coefficients_high, color)
    % Plot filled areas between regression lines
    Fx_fit_low = linspace(0, max(meanFx), 100);
    Fy_fit_low = polyval(coefficients_low, Fx_fit_low);

    Fx_fit_high = linspace(0, max(meanFx), 100);
    Fy_fit_high = polyval(coefficients_high, Fx_fit_high);

    fill([Fx_fit_low, fliplr(Fx_fit_high)], [Fy_fit_low, fliplr(Fy_fit_high)], color, 'FaceAlpha', 0.3);
end

function displayPhaseAngle(meanFx, meanFy, color, label, iteration)
    
    % Calculate phase angle
    angles_deg = rad2deg(atan(meanFy ./ meanFx));

    % Determine text position 
    text_y = 2.5 + iteration*0.2; % Adjust as needed for proper positioning

    % Display phase angle on the graph

    text(0.1, text_y, ['Phase ' label ': ' num2str(min(angles_deg)) ' - ' num2str(max(angles_deg)) ' degrees'], 'Color', color, 'FontSize', 18);

end


function compute_stats(meanFx, meanFy, material)


    % Compute phase angles from mean Fx and mean Fy
    Z = meanFx + 1j * meanFy;
    angles = rad2deg(angle(Z));

    % Calculate basic statistics for phase angles
    mean_angles = mean(angles);
    std_dev_angles = std(angles);
    min_angles = min(angles);
    max_angles = max(angles);
    median_angles = median(angles);
    unc_angles = std_dev_angles / sqrt(length(angles));
    three_sigma = 3*std_dev_angles;
    two_sigma = 2*std_dev_angles;

    % Display statistics for phase angles
    fprintf('\nStatistics for angles:\n');
    fprintf('Mean: %.2f\n', mean_angles);
    fprintf('Standard Deviation: %.2f\n', std_dev_angles);
    fprintf('Minimum: %.2f\n', min_angles);
    fprintf('Maximum: %.2f\n', max_angles);
    fprintf('Median: %.2f\n', median_angles);
    fprintf('Standard uncertainty: %.2f\n', unc_angles);
    fprintf('2 sigma: %.2f\n', two_sigma);

    % Create a boxplot
    figure;

    % Create boxplot with enhanced readability
    boxplot([angles'], 'Labels', {sprintf('%s (30 measures)', material)});

    % Accessing handles to adjust line width
    h = findobj(gca, 'Tag', 'Box');
    for i = 1:length(h)
        set(h(i), 'LineWidth', 1.5);
    end

    % Adjusting font size of labels
    set(gca, 'FontSize', 16);

    % Adding labels and title with improved font size
    ylabel('Phase angle values', 'FontSize', 16);
    title('Boxplot of phase angles', 'FontSize', 18);

    % Adjusting the plot appearance
    grid on;

    % Définition des valeurs
    delta_Fy = 0.045; % Incertitude sur Fy (delta_a)
    delta_Fx = 0.045; % Incertitude sur Fx (delta_b)
    
    % Calcul de l'incertitude sur atan(a/b)
    a = mean(meanFy); % Valeur de a
    b = mean(meanFx); % Valeur de b
    
    atan_value = atan(a/b); % Calcul de atan(a/b)
    delta_atan = sqrt((delta_Fy/(1 + (a/b)^2))^2 + ((a * delta_Fx)/(b^2*(1 + (a/b)^2)))^2); % Calcul de l'incertitude

    atan_value = rad2deg(atan_value); % Calcul de atan(a/b)
    delta_atan = rad2deg(delta_atan);

    % Affichage du résultat
    disp(['La valeur de atan(a/b) est : ', num2str(atan_value)]);
    disp(['L''incertitude sur atan(a/b) est : ', num2str(delta_atan)]);


    figure;

    % Define edges for histogram bins
    binEdges = linspace(min(angles), max(angles), 9);
    
    % Plot histogram
    histogram(angles, 'Normalization', 'pdf', 'BinMethod', 'auto');

    hold on;
    
    % Fit Gaussian distribution
    pd = fitdist(angles', 'Normal');
    x_values = linspace(min(angles), max(angles), 100);
    y_values = pdf(pd, x_values);
    
    % Plot fitted Gaussian distribution
    plot(x_values, y_values, 'r--', 'LineWidth', 2, 'DisplayName', 'Fitted Gaussian');
    
    % Add legend
    legend(sprintf('%s Phase Angle (PDF)', material), sprintf('Fitted Gaussian for %s', material), 'Location', 'best');

    
    % Add labels and title
    xlabel('Phase angle values');
    ylabel('Probability Density');
    title({sprintf('Histogram of %s Phase Angles with Fitted Gaussian Distribution', material)});
    
    % Add text box with mean and standard deviation
    mean_angle = mean(angles);
    std_dev_angle = std(angles);
    text_str = {sprintf('Mean: %.2f', mean_angle), sprintf('Standard Deviation: %.2f', std_dev_angle)};
    text(min(angles), max(y_values), text_str, 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'FontSize', 10);
    
    hold off;


end


function [angles] = compute_angles(meanFx, meanFy)


    % Compute phase angles from mean Fx and mean Fy
    Z = meanFx + 1j * meanFy;
    angles = rad2deg(angle(Z));


end


function [filtered_meanFx, filtered_meanFy] = filter_Fx_Fy(meanFx, meanFy)


    angles = compute_angles(meanFx, meanFy);
    mean_angles = mean(angles);
    std_dev_angles = std(angles);
    
    % Define the lower and upper bounds for filtering
    lower_bound = mean_angles - 2*std_dev_angles;
    upper_bound = mean_angles + 2*std_dev_angles;
    
    % Filter perlite_meanFx_combined and perlite_meanFy_combined based on filtered angles
    filtered_meanFx = meanFx(angles >= lower_bound & angles <= upper_bound);
    filtered_meanFy = meanFy(angles >= lower_bound & angles <= upper_bound);
end    

function color = getColorForIteration(a)
    % Predefined set of colors
    colors = {'r', 'g', 'b', 'c', 'm', 'y', 'k'};
    
    % Get color index based on the value of 'a'
    color_index = mod(a - 1, numel(colors)) + 1;
    
    % Retrieve color based on the color index
    color = colors{color_index};
end



