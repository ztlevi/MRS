function [ similarity ] = cosineSim( ratingArray_U, ratingArray_V )
%--------------------------------------------------------------------------
%COSINESIM calculate the cosine similarity for input array U and V
%
%   Program type: function
%
%   @input: ratingArray_U, ratingArray_V
%   @output: similarity
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% @author: Ting Zhou
% @date:   4.13.2016
% @copyright: Team Sherlock
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

    % initiate the variables
    numerator = 0; denominator_left = 0; denominator_right = 0;

    % ratingArray_U and ratingArray_V's length is the same
    for numOfTrack = 1 : length(ratingArray_U)
        numerator = numerator + ...
            ratingArray_U(numOfTrack) * ratingArray_V(numOfTrack);
        denominator_left = denominator_left + ratingArray_U(numOfTrack)^2;
        denominator_right = denominator_right + ratingArray_V(numOfTrack)^2;
    end

    similarity = numerator/(sqrt(denominator_left)*sqrt(denominator_right));

end

