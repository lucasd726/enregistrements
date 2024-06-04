% Demander à l'utilisateur le nom du test
test_name = input('Enter test name : ', 's');

% Obtenir le nom de l'utilisateur pour le chemin d'accès
user_name = getenv('USERNAME');

% Définir le chemin du dossier de stockage
folder_path = fullfile('C:', 'Users', user_name, 'Desktop', 'PRI', 'enregistrements', 'experiment_conditions');

% Créer le dossier s'il n'existe pas
if ~exist(folder_path, 'dir')
    mkdir(folder_path);
end

% Nom complet du fichier de test
filename = fullfile(folder_path, [test_name, '.txt']);

% Ouvrir le fichier pour écriture
fileID = fopen(filename, 'w');

% Vérifier si le fichier est ouvert avec succès
if fileID == -1
    error('Impossible d''ouvrir le fichier %s pour écriture.', filename);
end

% Fonction pour demander à l'utilisateur d'entrer une valeur
promptForInput = @(prompt) input(prompt, 's');

% Collect data from the user
excitation_frequency = promptForInput('Excitation frequency (in kHz) : ');
probe_type = promptForInput('Probe type : ');
material_tested = promptForInput('Material of the tested piece : ');
surface_condition = promptForInput('Surface condition of the tested piece : ');
environment_temperature = promptForInput('Environment temperature : ');
sample_temperature = promptForInput('Sample temperature : ');
electromagnetic_noise = promptForInput('Presence of external electromagnetic noise sources : ');
calibration_frequency = promptForInput('Zero calibration frequency : ');
nortec_angle = promptForInput('Nortec 600 angle setting (degrees) : ');
nortec_vertical_gain = promptForInput('Nortec 600 vertical gain (dB) : ');
nortec_horizontal_gain = promptForInput('Nortec 600 horizontal gain (dB) : ');
nortec_application = promptForInput('Nortec 600 application : ');

% Write the data to the file
fprintf(fileID, 'Test name : %s \n', test_name); 
fprintf(fileID, 'Excitation frequency: %s kHz \n', excitation_frequency);
fprintf(fileID, 'Probe type: %s\n', probe_type);
fprintf(fileID, 'Material of the tested piece: %s\n', material_tested);
fprintf(fileID, 'Surface condition of the tested piece: %s\n', surface_condition);
fprintf(fileID, 'Environment temperature: %s\n', environment_temperature);
fprintf(fileID, 'Sample temperature: %s\n', sample_temperature);
fprintf(fileID, 'Presence of external electromagnetic noise sources: %s\n', electromagnetic_noise);
fprintf(fileID, 'Zero calibration frequency: %s\n', calibration_frequency);
fprintf(fileID, 'Nortec 600 angle setting (degrees) : %s\n', nortec_angle);
fprintf(fileID, 'Nortec 600 vertical gain (dB) : %s\n', nortec_vertical_gain);
fprintf(fileID, 'Nortec 600 horizontal gain (dB) : %s\n', nortec_horizontal_gain);
fprintf(fileID, 'Nortec 600 application : %s\n', nortec_application);

fprintf(fileID, '\n', nortec_application);
fprintf(fileID, 'Template version : v1 \n', nortec_application);

% Fermer le fichier
fclose(fileID);

% Afficher un message de confirmation
fprintf('Fichier de test "%s" généré avec succès dans %s.\n', [test_name, '.txt'], folder_path);
