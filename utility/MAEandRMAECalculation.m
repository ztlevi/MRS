function [ MAEandRMAEArray ] = MAEandRMAECalculation( predictedResult )
%MAEANDRMAECALCULATION 
%   
%   Program type: function
%
%   @input: predictedResult
%   @output: MAE, RMAE
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% @author: Ting Zhou
% @date:   4.14.2016
% @copyright: Team Sherlock
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%% initiate variables

MAE = 0;
RMAE = 0;
MAEandRMAEArray = [];
totalMAE = 0;
totalRMAE = 0;
totalNumOfTracks = 0;

%% start calculate MAE and RMAE
for numOfUsers = 1 : length(predictedResult(:,1))
    
    MAE = 0;
    RMAE = 0;
    
    trackList = predictedResult{numOfUsers,1};
    
    % check if the user has tracks that can be recommended
    if isempty(trackList{1})
        
        MAEandRMAEArray(numOfUsers,1:2) = 0;
        
        continue;
        
    end
    
    for numOfTracks = 1 : length(trackList(:,1))
    
        predictedRating = trackList{numOfTracks,2};
        trueRating = trackList{numOfTracks,3};
        
        MAE = MAE + abs(predictedRating - trueRating);
        RMAE = RMAE + (predictedRating - trueRating)^2;
        
        totalNumOfTracks = totalNumOfTracks + 1; 
        
    end
    
    totalMAE = totalMAE + MAE;
    totalRMAE = totalRMAE + RMAE;
    
    
    MAE = MAE / numOfTracks;
    RMAE = sqrt(RMAE / numOfTracks);
    
    MAEandRMAEArray(numOfUsers,1) = MAE;
    MAEandRMAEArray(numOfUsers,2) = RMAE;
    
    
end
    
    totalMAE = totalMAE / totalNumOfTracks;
    totalRMAE = sqrt(totalRMAE / totalNumOfTracks);
    
    MAEandRMAEArray(numOfUsers+1,1) = totalMAE;
    MAEandRMAEArray(numOfUsers+1,2) = totalRMAE;

end

