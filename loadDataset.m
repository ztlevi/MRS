%--------------------------------------------------------------------------
%loadDataset    load json dataset and convert it into a better dataset
%
%   Program type: Script
%
%   @input:
%   @output:
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% @author: Ting Zhou
% @date:   3.27.2016
% @copyright: Team Sherlock
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%------------------ system initialization ---------------------------------
MRS_startup
warning off
dbstop if error

%------------------ read configuration file -------------------------------
configFile = './preamble/configuration.ini';
[homePath, dataRootPath, outputPath, ~] = loadGlobalPathSetting(configFile);

%---------------------------- read data -----------------------------------
jsonDataset = load([dataRootPath 'jsonDataset.mat']);
jsonDataset = jsonDataset.jsonDataset;
usernames = load([dataRootPath 'usernames.mat']);
usernames = usernames.usernames;

% get the size of the users
userSize = size(jsonDataset);
userSize = userSize(1,1);

i = 1; 
while i < userSize + 1
    weekSize = size(jsonDataset{i});
    weekSize = weekSize(1,2);
    jsonDataset{i} = transpose(jsonDataset{i});
    
    j = 1; numOfEmptyWeek = 0;
    while j < weekSize + 1
        jsonDataset{i}{j} = struct2cell(jsonDataset{i}{j});
        jsonDataset{i}{j} = clearEmptyMbid(cell2mat(jsonDataset{i}{j}{1}));
        if isempty(jsonDataset{i}{j})
            jsonDataset{i}{j} = {};
            numOfEmptyWeek = numOfEmptyWeek +1;
        else
            jsonDataset{i}{j} = table2array(struct2table(jsonDataset{i}{j}));
        end
        j = j + 1;
    end
    
    % delete the user if num of the empty week > weekSize - 12 ||
    % at least have 12 weeks' data
    if numOfEmptyWeek > weekSize - 12
        jsonDataset(i) = [];
        usernames(i) = [];
        userSize = userSize - 1;
        i = i -1;
    end
    i = i + 1;
end

usernames(:,2) = jsonDataset(:,1);
jsonDataset = usernames;

for i = 1 : userSize
    for j = 1 : size(jsonDataset{i,2})
        for k = 1 : size(jsonDataset{i,2}{j,1})
            if ischar(jsonDataset{i,2}{j,1})
                jsonDataset{i,2}{j,1} = [];
            else
                jsonDataset{i,2}{j,1}{k,2} = str2num(jsonDataset{i,2}{j,1}{k,2});
            end
        end
    end
    disp(['transform user ' num2str(i) '''s data']);
end

dataset = jsonDataset;
save([dataRootPath 'dataset.mat'], 'dataset');
delete([dataRootPath 'usernames.mat']);

