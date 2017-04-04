
clear all;
feature_train=load('features.train.txt');

N=length(feature_train);%the longest dimension
temp=feature_train;%set 建立temp预防自己修改原来的数据，以后有用


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
    %model=svmtrain(temp(:,1),temp(:,2:3),'-t 2 -g 100  -c cNew');cnew这样代入是错误的，要直接
    %因为那里面是'' 相当于字符串提取，不可以那样赋值，要注意， 于java区分
    for k=1:100
    clear train;
    clear test;
    clear acc;%%loop循环的时候，都要进行清零，这个是常见的处理技巧和思路
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
    [~,i]=max(acc(:,1));%返回index进行适当的检索运用，实现对应的功能！！注意学习体会。
    count(1,i)=count(1,i)+1;
    end


    