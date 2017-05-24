function [ gt,iMin,sMin,thetaMin ] = DTree( dataMatrix )% format of x1,x2,y matrix expansion
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[feature1Matrix,feature1Index]=sortrows(dataMatrix,1); %sort by the rows to get the new matrix
[feature2Matrix,feature2Index]=sortrows(dataMatrix,2);
N=size(dataMatrix,1); % the size of input sample number
M=2;% feature number
%%%%%%%%%%%%set the theta matrix
%%%%%%%%%%%%%%%%%%%%%%theta 1 function
for m=1:(N+1) %lead to high o(n), attention please
	if (m==1)
		theta1Vector(m,1)=-Inf;
    elseif (m==(N+1)) %m==1
            theta1Vector(m,1)=Inf;
    else
            theta1Vector(m,1)=1/2*(feature1Matrix(m,1)+feature1Matrix(m-1,1));
	end
end
%%%%%%%%%%%%%%%%%%%%%%theta 2 function
for m=1:(N+1) %lead to high o(n), attention please
	if (m==1)
		theta2Vector(m,1)=-Inf;
    elseif (m==(N+1)) %m==1
            theta2Vector(m,1)=Inf;
    else
            theta2Vector(m,1)=1/2*(feature2Matrix(m,2)+feature2Matrix(m-1,2));
	end
end
%%%%%%%%%%%%%%%%%%%%%%%%matrix setting finish

%%%%%%%set the termination criteria
if (sum(dataMatrix(:,3)==ones(N,1))==0)
    gt=-1;
    %%%%%%%%%%%%%later when coding for the sub tree return i think, even in
    %%%%%%%%%%%%%this condition we should return something correct???think
    %%%%%%%%%%%%%of it
    iMin=0;
    sMin=0;
    thetaMin=0;
    %return gt;
elseif  (sum(dataMatrix(:,3)==ones(N,1))==N)
    gt=1;
    iMin=0;
    sMin=0;
    thetaMin=0;
    %return gt;
    %%in my thinking when the xn is the same, then, the yn should be the same
    %%%%%%%% use the ein optimal to judge it but the coding part should
    %%%%%%%% have been run into the next step of the programming, ein
    %%%%%%%% optimal should have been done
else
    %%%%%%%%%%%%%for the dividing and conquer part
    %%%%%%parameter setting
    dir(1,1)=+1;
    dir(2,1)=-1;
    thetaAllCell=cell(2,1);
    thetaAllCell{1,1}=theta1Vector;
    thetaAllCell{2,1}=theta2Vector;
    minbValue=Inf;
    %%%%%%%%%%%%%%%%think to change it to matrix format without the for
    %%%%%%%%%%%%%%%%loops like the min comparison
    %%%%%%%%%step 1
    for i=1:2 % for the feature loop
        for s=1:2 % for the direcction loop
            for theta=1:(N+1)% for the feature loop
                bValue=branchPart(dataMatrix,i,dir(s,1),thetaAllCell{i,1}(theta,1));
                if (bValue<minbValue)
                    minbValue=bValue;
                    iMin=i;
                    sMin=dir(s,1);
                    thetaMin=thetaAllCell{i,1}(theta,1);
                end
            end
        end
    end
    disp('branch part')%%% q13 answer part for printing then getting the final result
    %%%%%%%step 2 for pure branching
    %%%%%%%%%%%%%%%%%%the later part
    yPredLab=sMin*sign((dataMatrix(:,iMin)-ones(N,1)*thetaMin));% a column vector
    posi1PreInde=find(yPredLab==(ones(N,1)*1));
    nega1PreInde=find(yPredLab==(ones(N,1)*(-1)));
    %%%%%%from index to matrix
    [posi1PreMatr]=dataMatrix(posi1PreInde,:);
    [nega1PreMatr]=dataMatrix(nega1PreInde,:);
    %%%%%%%%%step 3 build subTree
    [gtPosi1,iMinPosi1,sMinPosi1,thetaMinPosi1]=DTree(posi1PreMatr);% the imin,pos,just for judging?? 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%but we should return the same
    %format for the future processing for the usage.
    [gtNega1,iMinNega1,sMinNega1,thetaMinNega1]=DTree(nega1PreMatr);
    gt=[gtPosi1;gtNega1];
    iMin=[iMinPosi1;iMinNega1];
    sMin=[sMinPosi1;sMinNega1];
    thetaMin=[thetaMinPosi1;thetaMinNega1];
    %%%%%%%%%%%step 4 to sum all the gx but i think it may be used for the
    %%%%%%%%%%%prediction
    %gtPosi1*
    %iMin=[iMin]
end
end

