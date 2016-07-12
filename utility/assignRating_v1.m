% equal depth histogram

function [ data ] = assignRating( data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
totalPlayCounts = sum(cell2mat(data(:,2)));
dynamicTotalPlayCounts = totalPlayCounts;

% calculate standard diviation
sigma = std(cell2mat(data(:,2)),1);

% calcualte average
mu = mean(cell2mat(data(:,2)));

% calculate Coefficient of variation
CV = sigma/mu;

if CV < 0.5
    
    ratings = cell(1,length(data(:,1)));
    ratings(:) = {3};
    data = [data ratings'];
    
else

    for numOfTrack = 1 : length(data(:,1))
        % assign the rating(5,4,...,1) by checking if it is in the top 80% 
        %- 100% or 60% - 80%, or 40% - 20%, or 20% - 0% 
        dynamicTotalPlayCounts = dynamicTotalPlayCounts - data{numOfTrack,2};
        if dynamicTotalPlayCounts/totalPlayCounts >= 0.8

            data{numOfTrack,4} = 5;

        elseif dynamicTotalPlayCounts/totalPlayCounts >= 0.6

            data{numOfTrack,4} = 4;

        elseif dynamicTotalPlayCounts/totalPlayCounts >= 0.4

            data{numOfTrack,4} = 3;

        elseif dynamicTotalPlayCounts/totalPlayCounts >= 0.2

            data{numOfTrack,4} = 2;

        else

            data{numOfTrack,4} = 1;

        end    

    end

    % % optimize the rating by calculating the average rating for tracks
    % % that have the same play counts

    % for numOfTrack = 1 : length(data(:,1))
    %     playcounts = data{numOfTrack,2};
    %     % find all the tracks that have the same play counts;
    %     trackIdxWithSamePC = find(cell2mat(data(:,2)) == playcounts);
    %     averageRating = sum(cell2mat(data(trackIdxWithSamePC,4)))/length(trackIdxWithSamePC);
    %     data(trackIdxWithSamePC,4) = {averageRating};
    %     numOfTrack = numOfTrack + length(trackIdxWithSamePC) - 1;
    % end

end
end
