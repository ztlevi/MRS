function [ predictedRating ] = collaborativeFiltering( trackToPredict,...
                currentUser,similarUser,simMatrix, ratingDataset )
%COLLABORATIVEFILTERING 
%   
%   Program type: function
%
%   @input: trackToPredict
%   @output: predictedRating
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% @author: Ting Zhou
% @date:   4.14.2016
% @copyright: Team Sherlock
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%% initialize variables
currentUserAvgRating = 0;

similarUserAvgRating = 0;

similarUserRating = 0;

userSimilarity = 0;

numerator = 0;

denomiantor = 0;

%% get current user average rating
currentUserTestingData = ratingDataset{currentUser,2}{1};
numOfTracks = length(currentUserTestingData(:,1));
currentUserAvgRating = sum(cell2mat(currentUserTestingData(:,4)))/numOfTracks;

%% calculate the prediction rating

for numOfSimUser = 1 : length(similarUser{1})
    %% preparation
    % get similar user average rating
    simUserTrainingData = ratingDataset{similarUser{1}(numOfSimUser),2}{2};
    numOfTracks = length(simUserTrainingData(:,1));
    similarUserAvgRating = sum(cell2mat(simUserTrainingData(:,4)))/numOfTracks;
    
    % get the user similarity
    userSimilarity = simMatrix(currentUser, similarUser{1}(numOfSimUser));
    
    % get the similar user rating for certain track
    idxOfTrack = find(ismember(simUserTrainingData(:,3),trackToPredict)==1);
    similarUserRating = simUserTrainingData{idxOfTrack,4};
    
    %% calculate numerator
    numerator = numerator + ...
        userSimilarity * (similarUserRating - similarUserAvgRating);
    
    %% calculate denominator
    denomiantor = denomiantor + userSimilarity;
end

predictedRating = currentUserAvgRating + numerator / denomiantor;

end



