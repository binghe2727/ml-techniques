clear all;
disp('Load data and process data');
train=load('hw2_adaboost_train.dat'); % size n*3 dimension with feature1, feature2, label
[feature1Matrix,feature1Index]=sortrows(train,1);
[feature2Matrix,feature2Index]=sortrows(train,2);
N=size(feature1Matrix,1); % the size of input sample number
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
featureAllCell{1,1}=feature1Matrix;
featureAllCell{2,1}=feature2Matrix;

thetaAllCell=cell(2,1);
thetaAllCell{1,1}=theta1Vector;
thetaAllCell{2,1}=theta2Vector;
T=1;% for the iteration
alphaT=zeros(T,2);

%%%%%%%%%%%%%%%%%%5
for i=1:2  % feature space notation
	for t=1:T % the iteration notation
		disp(strcat(int2str(i),'feature',int2str(t),'iteration'));
		%disp()
		% high o(n) when use the all matrix to compute, it can decrease by for loop 
		% judge every iteration
		correctCell=cell(length(s),length(theta1Vector)); %%change it % one for cor,another for uncor
		correctCell(:,:)={zeros(N,1)};
		unCorrectCell=cell(length(s),length(theta1Vector));
		unCorrectCell(:,:)={zeros(N,1)};
		errorMatrix=zeros(length(s),length(theta1Vector));
		for ii=1:length(s) % s noation
			for jj=1:length(theta1Vector) % theta notation
				sumAll=0;

				for n=1:N
					if (s(ii,1)*signNew(featureAllCell{i,1}(n,1)-thetaAllCell{i,1}(jj,1)))==featureAllCell{i,1}(n,3)
						% corrent counting matrix setting
						correctCell{ii,jj}(n,1)=1;
						%disp('in the corret time'); %for debugging
					else
						unCorrectCell{ii,jj}(n,1)=1; % counting setting
						%disp('in the uncorret time');  %for debugging
						% accuracy computing
						sumAll=sumAll+1*uNCur(n,1);% first Time forget the uNCur, algorithm understanding
					end			
				end
				sumAll=sumAll/N;%change to point rate
				errorMatrix(ii,jj)=sumAll;%set the error number
			end
		end
		%%%%%%% begin getting the minium
		[r,c]=find(errorMatrix==min(min(errorMatrix)),1); % so many same min,then choose one
		%disp(min(min(errorMatrix)),1);
        disp(min(min(errorMatrix)));
		sumOfuNCur=sum(uNCur);
		epsilonT=min(min(errorMatrix))*N/sumOfuNCur;
		deltaT=sqrt((1-epsilonT)/epsilonT);
		%%%%%%%%%%update the uT+1
		%unCorrectCell{r,c}=unCorrectCell{r,c}*deltaT;
		%correctCell{r,c}=correctCell{r,c}/deltaT;
		corAndUncorMatrix=unCorrectCell{r,c}*deltaT+correctCell{r,c}/deltaT;
		%%%%%updating the uNCur
		uNCur=uNCur.*corAndUncorMatrix;
		%%%%%up the alphaT
		alphaT(t,i)=log(deltaT);
	end
end


predict(n,:)=abs(sign(train_set(:,3)'-sign(s(n,1)*(train_set(:,1)'-theta(n,1)')+s(n,2)*(train_set(:,2)'-theta(n,1)'))));