function [ totalWeekData ] = combineOneWeekData( totalWeekData, oneWeekData )
%COMBINEONEWEEKDATA Summary of this function goes here
if isempty(totalWeekData)
    totalWeekData = oneWeekData;
else
    for i = 1 : size(totalWeekData)
        for j = 1 : size(oneWeekData)
            % if mbid matches, add the playcounts together
            if totalWeekData{i,3}==oneWeekData{j,3}
                totalWeekData{i,2} = totalWeekData{i,2} + oneWeekData{j,2};
            end
        end
    end

    % if not exist, add the song to the totalWeekData
    for i = 1 : size(oneWeekData)
        if ~ismember(totalWeekData(:,3),oneWeekData(i,3))
           addPosition = size(totalWeekData);
           addPosition = addPosition(1,1) + 1;
           totalWeekData(addPosition , : ) = oneWeekData( i , : ); 
        end
    end
    [~, idx] = sort([totalWeekData{:,2}],'descend');
    totalWeekData = totalWeekData(idx,:,:);
end

