
clear all;
feature_train=load('features.train.txt');

N=length(feature_train);%the longest dimension
temp=feature_train;%set ����tempԤ���Լ��޸�ԭ�������ݣ��Ժ�����


C=[0.001,0.01,0.1,1,10];
count=[0,0,0,0,0];

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
    for k=1:100
    clear train;
    clear test;
    clear acc;%%loopѭ����ʱ�򣬶�Ҫ�������㣬����ǳ����Ĵ����ɺ�˼·
    shuffle=randperm(N);
    for n=1:1000
        test(n,:)=temp(shuffle(1,n),:);
    end
    
    for n=1001:N
        train(n,:)=temp(shuffle(1,n),:);
    end
    clear model;
    
    model(1,1)=svmtrain(train(:,1),train(:,2:3),'-t 2 -g 1  -c 0.1');
    [~, acc(1,1:3),~]=svmpredict(test(:,1),test(:,2:3),model(1,1));
    model(2,1)=svmtrain(train(:,1),train(:,2:3),'-t 2 -g 10  -c 0.1');
   [~, acc(2,1:3),~]=svmpredict(test(:,1),test(:,2:3),model(2,1));  
    model(3,1)=svmtrain(train(:,1),train(:,2:3),'-t 2 -g 100  -c 0.1');
    [~, acc(3,1:3),~]=svmpredict(test(:,1),test(:,2:3),model(3,1));  
    model(4,1)=svmtrain(train(:,1),train(:,2:3),'-t 2 -g 1000  -c 0.1');
    [~, acc(4,1:3),~]=svmpredict(test(:,1),test(:,2:3),model(4,1));  
    model(5,1)=svmtrain(train(:,1),train(:,2:3),'-t 2 -g 10000  -c 0.1');
    [~, acc(5,1:3),~]=svmpredict(test(:,1),test(:,2:3),model(5,1));  
    [~,i]=max(acc(:,1));%����index�����ʵ��ļ������ã�ʵ�ֶ�Ӧ�Ĺ��ܣ���ע��ѧϰ��ᡣ
    count(1,i)=count(1,i)+1;
    end


    