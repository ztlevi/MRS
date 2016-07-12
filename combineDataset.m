%--------------------------------------------------------------------------
%COMBINEDATASET    combine the weekly data into testing data(latest four
%week's data) and traing data(other data in a half year).
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
dataset = load([dataRootPath 'dataset.mat']);
dataset = dataset.dataset;

%---------------------------- data initialization -------------------------

% set the weeks's threshold to 4(total 26 weeks)
weekThreshold = 2;
% initiate the index
numOfUsers = 1;

while numOfUsers <= length(dataset(:,1))
    
    testingData = {}; trainingData = {};
    
    for numOfWeekss = 1 : weekThreshold
        
        testingData = combineOneWeekData(testingData, ...
            dataset{numOfUsers,2}{numOfWeekss,1});
        
    end
    
    for numOfWeekss = (weekThreshold + 1) : size(dataset{numOfUsers,2})
        
        trainingData = combineOneWeekData(trainingData, ...
           dataset{numOfUsers,2}{numOfWeekss,1});
       
    end
    
    % if the testing data or training data is empty, delete the user from
    % the dataset
    if isempty(testingData)|| isempty(trainingData)
        
        dataset(numOfUsers,:) = [];
        disp([num2str(numOfUsers) ' is deleted']);
        numOfUsers = numOfUsers - 1;
    else    
        dataset{numOfUsers,2} = {testingData; trainingData};
        disp([num2str(numOfUsers) '''s testing data and training data aer generated']);
    end
    
    numOfUsers = numOfUsers + 1;
    
end

combinedDataset = dataset;
save([dataRootPath '/' 'combinedDataset.mat'],'combinedDataset');