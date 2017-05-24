function [ yFinalPredict ] = DTPredictByRheap( dataTuple,r,order )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

%yFinalPredict=DTPredictByRheap(dataTuple,r);
%%%%%%
%dataTuple in the format of x1,x2,y
% r in the binary tree heap also in the divide and conquer search
if (r(order,2)==0)&(r(order,3)==0)&(r(order,4)==0) %leaf node
    yFinalPredict=r(order,1);
elseif ((r(order,3)*sign(dataTuple(r(order,2),1)-r(order,4)))==+1) % not leaf node to divide and conquer
        yFinalPredict=DTPredictByRheap( dataTuple,r,2*order );
else
        yFinalPredict=DTPredictByRheap( dataTuple,r,2*order+1 );
end

end

