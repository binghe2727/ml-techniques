function [ bValue ] = branchPart( dataMatrix,i,s,theta )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
N=size(dataMatrix,1);% the length or sieze or number of user
M=2;%feature number
%%%%%%%%%%%%%%%%%%the later part
yPredLab=s*sign((dataMatrix(:,i)-ones(N,1)*theta));% a column vector
posi1PreInde=find(yPredLab==(ones(N,1)*1));
nega1PreInde=find(yPredLab==(ones(N,1)*(-1)));
%%%%%%from index to matrix
posi1PreMatr=dataMatrix(posi1PreInde,:);
nega1PreMatr=dataMatrix(nega1PreInde,:);
%%%%%%%%%%%%compute the giniimpurity
bValue=size(posi1PreMatr,1)*impurityInGini(posi1PreMatr)+size(nega1PreMatr,1)*impurityInGini(nega1PreMatr);
end

