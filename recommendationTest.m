%--------------------------------------------------------------------------
%RECOMMENDATIONTEST    test the recommendation by looking at if the user
%listen to the songs recommended
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

%% initialization
commonTracksList = {};

%% load data needed
ratingDataset = load('./Data/ratingDataset.mat');
ratingDataset = ratingDataset.ratingDataset;
pearsonNeighborMatrix = load('./Output/pearsonNeighborMatrix_v3.mat');
pearsonNeighborMatrix = pearsonNeighborMatrix.pearsonNeighborMatrix;

%% search for common tracks of all similar users
for numOfUser = 1 : length(pearsonNeighborMatrix)
    commonTracks = [];
    if isempty(pearsonNeighborMatrix{numOfUser})
        commonTracks = [];
    else
       
        if length(pearsonNeighborMatrix{numOfUser}) >= 2
            % find training data for all similar users
            for numOfSimilarUser = 1 : length(pearsonNeighborMatrix{numOfUser})

                userIdx = pearsonNeighborMatrix{numOfUser}(numOfSimilarUser);
                trainingDataofSimilarUser = ratingDataset{userIdx,2}{2};
                tracksMBIDOfSimilarUser = trainingDataofSimilarUser(:,3);
                if numOfSimilarUser == 1
                    commonTracks = tracksMBIDOfSimilarUser;
                else
                    commonTracks = intersect(commonTracks, ...
                        tracksMBIDOfSimilarUser);
                end
            end

            % extract the train data of the current user, and unique the
            % training data's tracks with the commonTracks
            trainingDataOfCurrentUser = ratingDataset{numOfUser,2}{2};
            trainingTracksMBIDOfCurrentUser = trainingDataOfCurrentUser(:,3);
            foo = ~ismember(commonTracks, trainingTracksMBIDOfCurrentUser);

            commonTracks = commonTracks(find(foo));

            % extract the testing data of the current user
            testingDataOfCurrentUser = ratingDataset{numOfUser,2}{1};
            testingTracksMBIDOfCurrentUser = testingDataOfCurrentUser(:,3);
            commonTracks = intersect(commonTracks, testingTracksMBIDOfCurrentUser);
        
        end
    end
    if isempty(commonTracks)
    	commonTracks = {[]};
   	end
    commonTracksList = [commonTracksList; {commonTracks(:)}];

end

%% calcuate the hit rate

