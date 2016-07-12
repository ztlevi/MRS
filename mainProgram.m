%--------------------------------------------------------------------------
%MAINPROGRAM    The main program of the Music Recommendation System
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

%% ----------------- system initialization start --------------------------
MRS_startup
warning off
dbstop if error
% ------------------ system initialization end-----------------------------

%% ---------------- read configuration file start--------------------------
configFile = './preamble/configuration.ini';
[homePath, dataRootPath, outputPath, ~] = loadGlobalPathSetting(configFile);
% ----------------- read configuration file end----------------------------

%%------------------------- Equal depth result-----------------------------
ratingGeneration_v1;
pearsonSimMatrix = calculatePearsonSim(ratingDataset);
pearsonNeighborMatrix = generateNeighborMatrix(pearsonSimMatrix);
save('./Output/pearsonNeighborMatrix_v1.mat', 'pearsonNeighborMatrix');
pearsonPredictedResult = generateRecommendation(ratingDataset, ...
    pearsonNeighborMatrix, pearsonSimMatrix);
save('./Output/pearsonPredictedResult_v1.mat', 'pearsonPredictedResult');
MAEandRMAEArray = MAEandRMAECalculation(pearsonPredictedResult);
[confusionMatrix, TPR, FPR, Precision, Accuracy] = calculateConfusionMatrix(pearsonPredictedResult);
save('./Output/26weeks_2weeks_equaldepth_5scale_2edge.mat',...
    'pearsonNeighborMatrix','MAEandRMAEArray',...
    'confusionMatrix','TPR','FPR','Precision','Accuracy');
%-------------------------Equal depth result end---------------------------

%%------------------------- Equal width result ----------------------------
ratingGeneration_v2;
pearsonSimMatrix = calculatePearsonSim(ratingDataset);
pearsonNeighborMatrix = generateNeighborMatrix(pearsonSimMatrix);
save('./Output/pearsonNeighborMatrix_v2.mat', 'pearsonNeighborMatrix');
pearsonPredictedResult = generateRecommendation(ratingDataset, ...
    pearsonNeighborMatrix, pearsonSimMatrix);
save('./Output/pearsonPredictedResult_v2.mat', 'pearsonPredictedResult');
MAEandRMAEArray = MAEandRMAECalculation(pearsonPredictedResult);
[confusionMatrix, TPR, FPR, Precision, Accuracy] = calculateConfusionMatrix(pearsonPredictedResult);
save('./Output/26weeks_2weeks_equalwidth_5scale_2edge.mat',...
    'pearsonNeighborMatrix','MAEandRMAEArray',...
    'confusionMatrix','TPR','FPR','Precision','Accuracy');
%-------------------------Equal width result end---------------------------

%%------------------------- V-optimal result ------------------------------
ratingGeneration_v3;
pearsonSimMatrix = calculatePearsonSim(ratingDataset);
pearsonNeighborMatrix = generateNeighborMatrix(pearsonSimMatrix);
save('./Output/pearsonNeighborMatrix_v3.mat', 'pearsonNeighborMatrix');
pearsonPredictedResult = generateRecommendation(ratingDataset, ...
    pearsonNeighborMatrix, pearsonSimMatrix);
save('./Output/pearsonPredictedResult_v3.mat', 'pearsonPredictedResult');
MAEandRMAEArray = MAEandRMAECalculation(pearsonPredictedResult);
[confusionMatrix, TPR, FPR, Precision, Accuracy] = calculateConfusionMatrix(pearsonPredictedResult);
save('./Output/26weeks_2weeks_Voptimal_5scale_2edge.mat',...
    'pearsonNeighborMatrix','MAEandRMAEArray',...
    'confusionMatrix','TPR','FPR','Precision','Accuracy');
%-------------------------V-optimal result end-----------------------------

disp('finish');
