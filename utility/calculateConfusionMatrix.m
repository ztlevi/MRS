function [confusionMatrix, TPR, FPR, Precision, Accuracy] = calculateConfusionMatrix( predictedResult )
%CONFUSIONMATRIX 
%   
%   Program type: function
%
%   @input: predictedResult
%   @output: confusionMatrix
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% @author: Ting Zhou
% @date:   4.14.2016
% @copyright: Team Sherlock
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%% intialize variables
confusionMatrix = zeros(2,2);

TP = 0;
FP = 0;
FN = 0;
TN = 0;

edge = 2;

%% generate confusion matrix
for numOfUsers = 1 : length(predictedResult(:,1))

    trackList = predictedResult{numOfUsers,1};
    
    % check if the user has tracks that can be recommended
    if isempty(trackList{1})
        
        continue;
        
    end

    for numOfTracks = 1 : length(trackList(:,1))
    
        predictedRating = trackList{numOfTracks,2};
        trueRating = trackList{numOfTracks,3};
        
        if 0 <= predictedRating && predictedRating < edge ...
            && 0 <= trueRating && trueRating < edge
        
            TN = TN + 1;
            
        end
        
        if predictedRating >= edge ...
            && trueRating >= edge
        
            TP = TP + 1;
            
        end
        
        if predictedRating >= edge ...
            && 0 <= trueRating && trueRating < edge
        
            FP = FP + 1;
            
        end
        
        if 1 <= predictedRating && predictedRating < edge ...
            && trueRating >= edge
        
            FN = FN + 1;
            
        end
    
    end
    
end

%% calculate sensitivity, specificity, precision, accuracy

confusionMatrix(1,1) = TP;
confusionMatrix(2,2) = TN;
confusionMatrix(1,2) = FP;
confusionMatrix(2,1) = FN;

TPR = TP / (TP + FN);
FPR = FP / (FP + TN);
Precision = TP / (TP + FP);
Accuracy = (TP + TN) / (TP + TN + FP + FN);




end

