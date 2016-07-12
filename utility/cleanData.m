function [ data ] = cleanData( data )
%--------------------------------------------------------------------------
%CLEANDATA    delete tracks only have 1 play count
%
%   Program type: Script
%
%   @input: data
%   @output: data
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% @author: Ting Zhou
% @date:   4.10.2016
% @copyright: Team Sherlock
%--------------------------------------------------------------------------
numOfTrack = 1;
while numOfTrack < length(data(:,1))
    if (data{numOfTrack,2} == 1)
        data(numOfTrack,:) = [];
        numOfTrack = numOfTrack - 1;
    end
    numOfTrack = numOfTrack + 1; 
end

end

