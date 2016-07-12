function [ predictedResult] = generateRecommendation( ratingDataset, ...
    neighborMatrix, simMatrix)
%GENERATERECOMMENDATION 
%   
%   Program type: function
%
%   @input: ratingDataset, neighborMatrix
%   @output: recommendationMatrix
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% @author: Ting Zhou
% @date:   4.14.2016
% @copyright: Team Sherlock
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%% initiate variables
commonTracksList = {};
ratingDataset = load('./Data/ratingDataset.mat');
ratingDataset = ratingDataset.ratingDataset;

%% search for common tracks of all similar users
for numOfUser = 1 : length(neighborMatrix)
    if isempty(neighborMatrix{numOfUser})
        commonTracks = [];
    else
        % extract the testing data of the current user
        testingDataOfCurrentUser = ratingDataset{numOfUser,2}{1};
        tracksMBIDOfCurrentUser = testingDataOfCurrentUser(:,3);
        commonTracks = tracksMBIDOfCurrentUser;
        % find training data for all similar users
        for numOfSimilarUser = 1 : length(neighborMatrix{numOfUser})
            userIdx = neighborMatrix{numOfUser}(numOfSimilarUser);
            trainingDataofSimilarUser = ratingDataset{userIdx,2}{2};
            tracksMBIDOfSimilarUser = trainingDataofSimilarUser(:,3);
            commonTracks = intersect(commonTracks, ...
                tracksMBIDOfSimilarUser);

        end
    end
    if isempty(commonTracks)
    	commonTracks = {[]};
   	end
    commonTracksList = [commonTracksList; {commonTracks(:)}];

end

%% generate recommendation for each track in common track list
for numOfUser = 1 : length(commonTracksList(:,1))
    % check if the current users has common tracks with other similar users
    if ~isempty(commonTracksList{numOfUser,1}{1})
        for numOfCommonTrack = 1 : length(commonTracksList{numOfUser,1})
            trackToPredict = commonTracksList{numOfUser,1}(numOfCommonTrack);
            currentUser = numOfUser;
            similarUser = neighborMatrix(currentUser);
            if ~isempty(similarUser)
                %get the rating from the current user
                currentUserRating = ratingDataset{numOfUser,2}{1}{find(ismember(ratingDataset{numOfUser,2}{1}(:,3),trackToPredict) == 1),4};
                % get the predicted rating for one track
                predictedRating = collaborativeFiltering(trackToPredict,...
                    currentUser,similarUser,simMatrix, ratingDataset);
                
                % store predicted rating and current user rating
                commonTracksList{numOfUser}{numOfCommonTrack,2} = predictedRating;
                commonTracksList{numOfUser}{numOfCommonTrack,3} = currentUserRating;

            end
        end
    end

end

predictedResult = commonTracksList;