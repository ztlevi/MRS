% V-optimal histogram

function [ data ] = assignRating_v3( data )

playcountsArray = cell2mat(data(:,2));
playcountsCategories = unique(playcountsArray);
playcountSortation = [playcountsCategories,histc(playcountsArray(:),playcountsCategories)];
totalPlayCounts = sum(playcountSortation(:,2));

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

    [~, ~, ~, edges] = sshist(playcountSortation(:,1),6);

    for numOfTrack = 1 : length(data(:,1))

        if playcountsArray(numOfTrack) >= edges(5) 

            data{numOfTrack,4} = 5;

        elseif playcountsArray(numOfTrack) >= edges(4) && ...
                playcountsArray(numOfTrack) < edges(5)

            data{numOfTrack,4} = 4;

        elseif playcountsArray(numOfTrack) >= edges(3) && ...
                playcountsArray(numOfTrack) < edges(4)

            data{numOfTrack,4} = 3;

        elseif playcountsArray(numOfTrack) >= edges(2) && ...
                playcountsArray(numOfTrack) < edges(3)

            data{numOfTrack,4} = 2;

        elseif playcountsArray(numOfTrack) < edges(2)

            data{numOfTrack,4} = 1;

        end

    end

end

