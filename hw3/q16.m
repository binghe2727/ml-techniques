%%%%%%%%%%%%q16 gett
clear all;
data=load('hw3_train.dat'); 
sumAll=0;
for i=1:100
    for j=1:300
        fprintf('i is %d j is %d \n',i,j)
        sampleInd=randi(100,100,1);
        trainData=data(sampleInd,:);
        r=[];% for building of the decisionTree
        %r(5,1)=0;
        order=1;
        pareNodeValue=0;
        %r,1=0/1,r2=i,r3=s;r4=theta,r5=order
        [gt,iMin,sMin,thetaMin,r ] = DTreePredict( pareNodeValue,trainData,r,order );
        %%%%%%%%%%test error
        sum=0;
        trainData=load('hw3_train.dat'); %only for the q15;cancel it for q14
        for ii=1:size(trainData,1)
            yFinalPredict=DTPredictByRheap(trainData(ii,:)',r,1);
            if yFinalPredict~=trainData(ii,3)
                sum=sum+1;
            end
        end
        errRate=sum/size(trainData,1);
        %%%%%%%%adding up
        sumAll=sumAll+errRate;
    end
end
finalRate=sumAll/30000;