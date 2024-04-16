function FullFileName = usergetfiles(varagin)
% USER GET FILES
% multiselection == on; single file selection is also allowed.
n = nargin;

if n == 0
    [filenames,inputdir] = uigetfile(['.mat'],'MultiSelect','on');
elseif n == 1
    startpath = varagin(1);
    [filenames,inputdir] = uigetfile([startpath,'.mat'],'MultiSelect','on');
elseif n > 1
    error('Too many input arguments')
end

if ~iscell(filenames) % Convert filenames variable in cell array if a single file has been selected.
    filenames = {filenames}; % the code try to access filenames' content by indexing with curly braces, {}.
end

FullFileName = {};
for k = 1:numel(filenames)
    FullFileName = [FullFileName,[inputdir,filenames{k}]];
end
end