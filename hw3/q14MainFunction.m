%%%%%%%%%%%%%%q13main function
clear all;
disp('Load data and process data');
trainData=load('hw3_train.dat'); 
r=[];% for building of the decisionTree
%r(5,1)=0;
order=1;
pareNodeValue=0;
%r,1=0/1,r2=i,r3=s;r4=theta,r5=order
[gt,iMin,sMin,thetaMin,r ] = DTreePredict( pareNodeValue,trainData,r,order );
% r is the tree, but it is presented in the format of binary heap!!!then
% ,learn to use it for the final predict
%if it is +1 then in the left leaf node, if it is -1 in the right leaf node
sum=0;
trainData=load('hw3_test.dat'); %only for the q15;cancel it for q14

for i=1:size(trainData,1)
    yFinalPredict=DTPredictByRheap(trainData(i,:)',r,1);
    if yFinalPredict~=trainData(i,3)
        sum=sum+1;
    end
end
errRate=sum/size(trainData,1);