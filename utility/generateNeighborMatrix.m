function [ neighborMatrix ] = generateNeighborMatrix( simMatrix )
%GENERATENEIGHBORMATRIX for input similarity matrix, generate the neighbor
%matrix of users
%
%   Program type: function
%
%   @input: simMatrix
%   @output: neighborMatrix
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% @author: Ting Zhou
% @date:   4.14.2016
% @copyright: Team Sherlock
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
    
neighborMatrix = {};
neighborThreshold = 0.625;

for numOfUser_row = 1 : length(simMatrix)
    neighborList = [];
    for numOfUser_colum = 1 : length(simMatrix)
        if numOfUser_row ~= numOfUser_colum ...
           && simMatrix(numOfUser_row, numOfUser_colum) > neighborThreshold
            neighborList = [neighborList, numOfUser_colum];
        end
    end
    if isempty(neighborList)
        neighborList = {[]};
    end
    neighborMatrix = [neighborMatrix; neighborList];
end



end

