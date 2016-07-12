% equal width histogram

function [ data ] = assignRating_v2( data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
playcountsArray = cell2mat(data(:,2));
playcountsCategory = unique(playcountsArray);
minValue = playcountsCategory(1);
maxValue = playcountsCategory(end);
step = (maxValue - minValue)/5;

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

        if playcountsArray(numOfTrack) > step * 4

            data{numOfTrack,4} = 5;

        elseif playcountsArray(numOfTrack) > step * 3

            data{numOfTrack,4} = 4;

        elseif playcountsArray(numOfTrack) > step * 2

            data{numOfTrack,4} = 3;

        elseif playcountsArray(numOfTrack) > step * 1

            data{numOfTrack,4} = 2;

        else

            data{numOfTrack,4} = 1;

        end

    end
end
end
    

