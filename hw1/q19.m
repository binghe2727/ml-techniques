
clear all;
feature_train=load('features.train.txt');
feature_test=load('features.test.txt');
N=length(feature_train);%the longest dimension
temp=feature_train;%set ����tempԤ���Լ��޸�ԭ�������ݣ��Ժ�����
tempTest=feature_test;
k=1;%��̬������ɹ���һ������
C=[0.001,0.01,0.1,1,10];
for n=1:length(feature_test)
            %%%%%%%%%%change test data
            if(feature_test(n,1)~=0)
                 tempTest(n,1)=-1;
            else
                tempTest(n,1)=+1;
            end
            %%%%%%%%%%%%change test data
end

%for m=1:5
    for n=1:N
            if(feature_train(n,1)~=0)
                temp(n,1)=-1;
            else
                temp(n,1)=+1;
            end

    end
    %cNew=C(1,m);
    %model=svmtrain(temp(:,1),temp(:,2:3),'-t 2 -g 100  -c cNew');cnew���������Ǵ���ģ�Ҫֱ��
    %��Ϊ��������'' �൱���ַ�����ȡ��������������ֵ��Ҫע�⣬ ��java����
    model(1,1)=svmtrain(temp(:,1),temp(:,2:3),'-t 2 -g 1  -c 0.1');
    [~, acc(1,1:3),~]=svmpredict(tempTest(:,1),tempTest(:,2:3),model(1,1));
    model(2,1)=svmtrain(temp(:,1),temp(:,2:3),'-t 2 -g 10  -c 0.1');
   [~, acc(2,1:3),~]=svmpredict(tempTest(:,1),tempTest(:,2:3),model(2,1));  
    model(3,1)=svmtrain(temp(:,1),temp(:,2:3),'-t 2 -g 100  -c 0.1');
    [~, acc(3,1:3),~]=svmpredict(tempTest(:,1),tempTest(:,2:3),model(3,1));  
    model(4,1)=svmtrain(temp(:,1),temp(:,2:3),'-t 2 -g 1000  -c 0.1');
    [~, acc(4,1:3),~]=svmpredict(tempTest(:,1),tempTest(:,2:3),model(4,1));  
    model(5,1)=svmtrain(temp(:,1),temp(:,2:3),'-t 2 -g 10000  -c 0.1');
    [~, acc(5,1:3),~]=svmpredict(tempTest(:,1),tempTest(:,2:3),model(5,1));  
    %%%%%%%%%test eout

    