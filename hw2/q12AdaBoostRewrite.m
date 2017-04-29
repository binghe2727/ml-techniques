%%%%%%%%%%%%%%%finish by hebing
%%%%%%%%%%%%the seconde changes 

clear all;
disp('Load data and process data');
train=load('hw2_adaboost_train.dat'); % size n*3 dimension with feature1, feature2, label
test=load('hw2_adaboost_test.dat'); % size n*3 dimension with feature1, feature2, label
[feature1Matrix,feature1Index]=sortrows(train,1);
[feature2Matrix,feature2Index]=sortrows(train,2);
N=size(feature1Matrix,1); % the size of input sample number
M=2;% feature number
for m=1:N %lead to high o(n), attention please
	if (m>1)
		theta1Vector(m,1)=1/2*(feature1Matrix(m,1)+feature1Matrix(m-1,1));
	else %m==1
		theta1Vector(m,1)=-Inf;
	end
end

for m=1:N
	if (m>1)
		theta2Vector(m,1)=1/2*(feature2Matrix(m,1)+feature2Matrix(m-1,1));
	else %m==1
		theta2Vector(m,1)=-Inf;
	end
end
%%%s parameter setting
s(1,1)=1;
s(2,1)=-1;
disp('start bootstrap');
uNCur=(1/N)*ones(N,1);
%uNnext=zeros(N,1);
%%%%%%%after psudo code thinking, we use the cell to get more matrix component
%%%%%%%%%%%% feature matrix setting for loop, computation 
featureAllCell=cell(2,1);
%recovering the ranking of 
%[feature1Matrix,feature1Index]=sortrows(train,1);

featureAllCell{1,1}=train;
featureAllCell{2,1}=train;

thetaAllCell=cell(2,1);
thetaAllCell{1,1}=theta1Vector;
thetaAllCell{2,1}=theta2Vector;
T=300;% for the iteration
alphaT=zeros(T,2);
%%%%%%%%%%%%%%%%%%%%%%%%q13 setting matrix
thetaIterMatrix=zeros(T,M);
thetaIter0And1SetMatrix=zeros(T,M);
sSetMatrix=zeros(T,1);%  later should double in computation
alphaT=zeros(T,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(sum(uNCur));
epsilonTMin=1;
%%%%%%%%%%%%%%%%%%5
for t=1:T 
    %disp(strcat(int2str(t),'iteration'));
    corrMatrix=zeros(M,length(s),N,N);
    inCorrMatrix=zeros(M,length(s),N,N);
    errorMatrix=zeros(M,length(s),N);
    for i=1:M  % feature space notation
	% the iteration notation
		%disp(strcat(int2str(i),'feature',int2str(t),'iteration'));
		%disp()
		% high o(n) when use the all matrix to compute, it can decrease by for loop 
		% judge every iteration		
		for ii=1:length(s) % s noation
			for jj=1:N % theta notation
				sumAll=0;
				for n=1:N
					if ((s(ii,1)*sign(featureAllCell{i,1}(n,i)-thetaAllCell{i,1}(jj,1)))==featureAllCell{i,1}(n,3))
						% corrent counting matrix setting
						corrMatrix(i,ii,jj,n)=1;
						%disp('in the corret time'); %for debugging
					else
						inCorrMatrix(i,ii,jj,n)=1; % counting setting
						%disp('in the uncorret time');  %for debugging
						% accuracy computing
						sumAll=sumAll+1*uNCur(n,1);% first Time forget the uNCur, algorithm understanding
					end			
				end
				%sumAll=sumAll;%change to point rate
				errorMatrix(i,ii,jj)=sumAll;%set the error number
			end
        end
    end
	%%%%%%% begin getting the minium
% 	minError=min(min(min(errorMatrix)));
% 	[r,c,d]=find(errorMatrix==minError); % so many same min,then choose one
    [minError index]=min(errorMatrix(:));
    [r,c,d]=ind2sub(size(errorMatrix),index);% r: feature 1,2,    c: s value=1:2 for 1 -1 ,     d: corresponding theresh hold value 1-N for so  many correso
	%disp(min(min(errorMatrix)),1);
    %disp(minError);
	sumOfuNCur=sum(uNCur);
	
	epsilonT=minError/sumOfuNCur;
    if(epsilonT<epsilonTMin)
        epsilonTMin=epsilonT;
    end
	deltaT=sqrt((1-epsilonT)/epsilonT);
	%%%%%%%%%%update the uT+1
	%unCorrectCell{r,c}=unCorrectCell{r,c}*deltaT;
	%correctCell{r,c}=corrMatrix(r,c,d,:)/deltaT;
	%corAndUncorMatrix=inCorrMatrix(r,c,d,:)*deltaT+corrMatrix(r,c,d,:)/deltaT;
    for kk=1:N
        corAndUnCorMatrix(kk,1)=inCorrMatrix(r,c,d,kk)*deltaT+corrMatrix(r,c,d,kk)/deltaT;
    end
	%%%%%updating the uNCur
    if t<=(T)
        uNCur=uNCur.*corAndUnCorMatrix;
        
    end
    %disp(sum(uNCur));
	%%%%%up the alphaT
	alphaT(t,1)=log(deltaT);
    %%%%%%%%%%%%%%%%%soluiton for q13 to get the matrix computation
    thetaIterMatrix(t,r)=thetaAllCell{r,1}(d,1);
    thetaIter0And1SetMatrix(t,r)=1;
    if (c==1)
    	sSetMatrix(t,1)=1;
    else
    	sSetMatrix(t,1)=-1;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%q13  setting
end
    
%%%%%%%%%%q12:
% obtain by setting t=1, get minError
% %%%%%q13:
train=load('hw2_adaboost_train.dat');
errorAll=0;

%%%%%%%%%%%%%%%%%%q17

TestAll=test;% testing matrix
Nall=size(TestAll,1);%rename
%%%%%%%%%%%%%%%%%%

for n=1:Nall %N should be changed when testing on different data
	testMatrix=[];
	for m=1:T
		testMatrix=[testMatrix;TestAll(n,1:2)];
        
    end
    if sign((sum((sign((testMatrix-thetaIterMatrix).*thetaIter0And1SetMatrix))')).*(sSetMatrix')*alphaT)~=TestAll(n,3) 
        errorAll=errorAll+1;
    end
	%errorAll=errorAll+(sum((sign((testMatrix-thetaIterMatrix).*thetaIter0And1SetMatrix))')).*(sSetMatrix')*alphaT;
end
errorAllRate=errorAll/Nall;