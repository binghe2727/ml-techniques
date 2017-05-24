%%%%%%%%%%%%%%q13main function
clear all;
disp('Load data and process data');
trainData=load('hw3_train.dat'); 
[gt,iMin,sMin,thetaMin ] = DTree( trainData );