function [ giniIndex ] = impurityInGini( dataMatrix )
%better to set for the k classes in this condition we just consider the two
%but for a better programming format we should use(dataMatrix,[k1,k2,k3])
%to better formulate the programming, although you do not consider it in
%this programming task, but in the future use, you should think of this use
%for becoming a better programmer.
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
N=size(dataMatrix,1);% the length or sieze or number of user
M=2;%feature number
%%%%%%%%%%%%%%%%%%5
%%%yPredLab=s*sign((dataMatrix(:,i)-ones(N,1)*theta));% a column vector,
%%%but not need to use the predicted label for later computing
% posi1pury=(sum(find((dataMatrix(:,3)==ones(N,1))))/N)^2; %%add find is
% not correct because find is used for getting the index number it is very
% large
% nega1pury=(sum(find((dataMatrix(:,3)==(ones(N,1)*(-1)))))/N)^2;

posi1pury=(sum(dataMatrix(:,3)==ones(N,1))/N)^2;
nega1pury=(sum(dataMatrix(:,3)==(ones(N,1)*(-1)))/N)^2;

giniIndex=1-posi1pury-nega1pury;
end

