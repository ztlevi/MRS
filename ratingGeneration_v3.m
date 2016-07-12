%--------------------------------------------------------------------------
%RATINGGENERATION    generate the rating of tracks for each user
%
%   Program type: Script
%
%   @input:
%   @output:
%-------------------------------------------------------------------------

%--------------------------------------------------------------------------
% @author: Ting Zhou
% @date:   4.10.2016
% @copyright: Team Sherlock
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%------------------ system initialization ---------------------------------
MRS_startup
warning off
dbstop if error
clear all;

%------------------ read configuration file -------------------------------
configFile = './preamble/configuration.ini';
[homePath, dataRootPath, outputPath, ~] = loadGlobalPathSetting(configFile);

%---------------------------- read data -----------------------------------
combinedDataset = load([dataRootPath 'combinedDataset.mat']);
combinedDataset = combinedDataset.combinedDataset;

%----------------------------generate rating-------------------------------
for numOfUser = 1 : length(combinedDataset(:,1))
    testingData = combinedDataset{numOfUser,2}{1};
    trainingData = combinedDataset{numOfUser,2}{2};
    %assign the rating to the tracks of one user

    trainingData = assignRating_v3(trainingData);
    testingData = assignRating_v3(testingData);

    combinedDataset{numOfUser,2}{2} = trainingData;
    combinedDataset{numOfUser,2}{1} = testingData;
    disp([num2str(numOfUser) '''s ratings are genereated']);
end
ratingDataset = combinedDataset;
save([dataRootPath 'ratingDataset.mat'],'ratingDataset');
