function userSimMatrix = calculateCosineSim( ratingDataset )
%--------------------------------------------------------------------------
%CALCULATESIM    calculate the cosine similarity between users and generate a
%user-user similarity matrix
%
%   Program type: Script
%
%   @input: ratingDataset
%   @output: userSImMatrix
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% @author: Ting Zhou
% @date:   4.13.2016
% @copyright: Team Sherlock
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% initiate user similarity matrix
userNum = length(ratingDataset(:,1));
userSimMatrix = zeros(userNum);

% start calculate the similarity between users
for numOfUser_U = 1 : userNum
    trainingData_U = ratingDataset{numOfUser_U,2}{2};
    for numOfUser_V = 1 : userNum
        trainingData_V = ratingDataset{numOfUser_V,2}{2};
        
        % extract MBID set of two users
        MBIDSet_U = ratingDataset{numOfUser_U,2}{2}(:,3);
        MBIDSet_V = ratingDataset{numOfUser_V,2}{2}(:,3);
        
        % search the common tracks between two users
        [~,idxesOfTracks_U,idxesOfTracks_V] = ...
            intersect(MBIDSet_U,MBIDSet_V, 'stable');
        ratingArray_U = cell2mat(trainingData_U(idxesOfTracks_U(:),4));
        ratingArray_V = cell2mat(trainingData_V(idxesOfTracks_V(:),4));
        
        % chekc whether there are more than 1 common track or not
        if length(ratingArray_U) >= 2 && length(ratingArray_V) >= 2
            % cacluate the correlation coefficients between two users
            similarity = cosineSim(ratingArray_U, ratingArray_V);
        
            userSimMatrix(numOfUser_U, numOfUser_V) = similarity;
            userSimMatrix(numOfUser_V, numOfUser_U) = similarity;
        else
            userSimMatrix(numOfUser_U, numOfUser_V) = 0;
            userSimMatrix(numOfUser_V, numOfUser_U) = 0;
        end
    end
end

save('./Output/CosineSimMatrix.mat', 'userSimMatrix');
end
