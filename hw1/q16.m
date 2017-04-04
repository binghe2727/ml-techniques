
clear all;
feature_train=load('features.train.txt');
N=length(feature_train);%the longest dimension
temp=feature_train;%set 建立temp预防自己修改原来的数据，以后有用
k=1;%动态设计生成构造一个数组
for m=[0,2,4,6,8]
    for n=1:N
    if(feature_train(n,1)~=m)
        temp(n,1)=-1;
    else
        temp(n,1)=+1;
    end
    end
    model=svmtrain(temp(:,1),temp(:,2:3),'-t 1 -g 1 -r 1 -c 0.01 -d 2');
   %question 17
   alpha(k,1)=m;
   alpha(k,2)=sum(abs(model.sv_coef));
   %qeustion 17 finished
    [predLabel, acc(k,1:3),decisValue]=svmpredict(temp(:,1),temp(:,2:3),model);
    acc(k,4)=m;
    k=k+1;
end


% w=model.SVs'*model.sv_coef;
% answer=sqrt(w'*w)
