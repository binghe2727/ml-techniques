%q18 solution
clear all;
data=load('hw2_lssvm_all.dat');
train=data(1:400,1:10);
trainLabel=data(1:400,11);
N=size(train,1);%the number of trainning data
test0=data(401:end,1:10);
testLabel0=data(401:end,11);
gamma=[32;2;0.125];
lambda=[0.001;1;1000];

errorMatrix=zeros(3,3);

for i=1:3%for gamma loop
    for j=1:3%for lambda loop
        %%%%%%%%%%%get the beta by kernel function
        disp('build the kernel');
        K=[];
        for k=1:N
            Xn=[];
            for ii=1:N % for construction loop
                Xn=[Xn;train(k,:)];
            end
            Xnm=Xn-train;
            for ii=1:N % computing loop
                KCol(ii,1)=exp(-gamma(i,1)*norm(Xnm(ii,:))^2);
            end
            K=[K,KCol];
        end
        I=eye(400);
        beta=inv(lambda(j,1)*I+K)*trainLabel; %size of 400*1

        %%%%%%%%%%%notation for testing in further loop
        disp('compur the label');
%         test=train;
%         testLabel=trainLabel;
        
        test=test0;
        testLabel=testLabel0;
        
        Ntest=size(test,1);
        errorSum=0;
        for t=1:Ntest
            xT=[];
            for tt=1:N
                xT=[xT;test(t,:)];
            end
            xT=xT-train;
            for ttt=1:N
                Ktest(ttt,1)=exp(-gamma(i,1)*norm(xT(ttt,:))^2);
            end
            if sign(Ktest'*beta)~=testLabel(t,1)
                errorSum=errorSum+1;
            end
        end
        errorMatrix(i,j)=errorSum/Ntest;
    end
end
disp(min(errorMatrix(:)));
disp(max(errorMatrix(:)));