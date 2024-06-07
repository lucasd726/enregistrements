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
fprintf('\nStatistics for angles %s :\n', material);
fprintf('Mean: %.2f\n', mean_angles);
fprintf('Standard Deviation: %.2f\n', std_dev_angles);
fprintf('Minimum: %.2f\n', min_angles);
fprintf('Maximum: %.2f\n', max_angles);
fprintf('Median: %.2f\n', median_angles);
fprintf('Standard uncertainty: %.2f\n', unc_angles);
fprintf('2 sigma: %.2f\n', two_sigma);


% OLD CODE, Define grid for Gaussian distributions
% grid_size = 1000; % Adjust grid size as needed

% Fx_grid = linspace(0, max(meanFx), grid_size);
% Fy_grid = linspace(0, max(meanFy), grid_size);

% Fx_grid = linspace(max(meanFx) - 0.5, max(meanFx)+0.1, grid_size);
% Fy_grid = linspace(max(meanFy) - 0.5, max(meanFy)+0.1, grid_size);
% [Fx_mesh, Fy_mesh] = meshgrid(Fx_grid, Fy_grid);

% Parameters for Gaussian distribution
% sigma = std_dev_angles; % Standard deviation for Gaussian

% Initialize the figure
% figure;
% hold on;

% Calculate the angle of each grid point
% Z_mesh = Fx_mesh + 1j * Fy_mesh;
% mesh_angles = rad2deg(angle(Z_mesh));

% Create a mask for points within the angle range
% angle_mask = (mesh_angles >= min_angles) & (mesh_angles <= max_angles);

% Z_gaussian = normpdf(mesh_angles, mean_angles, sigma);

% Apply the mask to the Gaussian distribution
% Z_gaussian = Z_gaussian .* angle_mask;

% Plot the Gaussian surface if there are any valid points
% if any(Z_gaussian(:))
%     surf(Fx_mesh, Fy_mesh, Z_gaussian, 'EdgeColor', 'none', 'FaceAlpha', 0.8);
% end
% 
% % Calculate Z_gaussian values for meanFx and meanFy points
% mean_Z = normpdf(angles, mean_angles, sigma);
% 
% % Plot meanFx and meanFy points on the surface plot
% scatter3(meanFx, meanFy, mean_Z, 50, 'r');

% Set colormap and labels
% colormap('jet');
% colorbar;
% xlabel('Fx');
% ylabel('Fy');
% zlabel('Gaussian Intensity');
% title('3D Gaussian Distributions on Impedance Plane');

% Adjust plot appearance
% view(3);
% hold off;

% Create a boxplot
figure;

% Compute the number of measures
num_measures = length(angles);

% Create the label string with the material name and the number of measures
label_str = sprintf('%s (%d measures)', material, num_measures);

% Create boxplot with enhanced readability
boxplot([angles'], 'Labels', {label_str});

% Accessing handles to adjust line width
h = findobj(gca, 'Tag', 'Box');
for i = 1:length(h)
    set(h(i), 'LineWidth', 1.5);
end

% Adjusting font size of labels
set(gca, 'FontSize', 16);

% Adding labels and title with improved font size
ylabel('Phase angle values (φ)', 'FontSize', 16);
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
delta_atan = sqrt( ( delta_Fy/(b*(1 + (a/b)^2)) )^2 + ( (a * delta_Fx)/(b^2*(1 + (a/b)^2)) )^2 ); % Calcul de l'incertitude

% delta_atan = sqrt((delta_Fy*b/(a^2 + b^2))^2 + ((a * delta_Fx)/(b^2 + a^2))^2); % Calcul de l'incertitude


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
legend(sprintf('%s Phase Angle', material), sprintf('Fitted Gaussian for %s', material), 'Location', 'best');


% Add labels and title
xlabel('Phase angle values (φ)');
ylabel('Probability Density');
title({sprintf('Histogram of %s Phase Angles with Fitted Gaussian Distribution', material)});

% Add text box with mean and standard deviation
mean_angle = mean(angles);
std_dev_angle = std(angles);
text_str = {sprintf('Mean: %.2f', mean_angle), sprintf('Standard Deviation: %.2f', std_dev_angle)};
text(min(angles), max(y_values), text_str, 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'FontSize', 10);

hold off;


end