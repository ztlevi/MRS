function [ currentUser ] = clearEmptyMbid( currentUser )
    userSize = size(currentUser);
    userSize = userSize(2);
    i = 1;
    while i <= userSize
        if isempty(currentUser(i).mbid)
            currentUser(i)=[];
            userSize = userSize - 1;
            i = i -1;
        end
        i = i + 1;
    end
end