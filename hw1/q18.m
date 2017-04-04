
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
    model(1,1)=svmtrain(temp(:,1),temp(:,2:3),'-t 2 -g 100  -c 0.001');
    model(2,1)=svmtrain(temp(:,1),temp(:,2:3),'-t 2 -g 100  -c 0.01');
    model(3,1)=svmtrain(temp(:,1),temp(:,2:3),'-t 2 -g 100  -c 0.1');
    model(4,1)=svmtrain(temp(:,1),temp(:,2:3),'-t 2 -g 100  -c 1');
    model(5,1)=svmtrain(temp(:,1),temp(:,2:3),'-t 2 -g 100  -c 10');
    %%%%%%%%%test eout
    for k=1:5%model loop parameter.
    [predLabel, acc(k,1:3),decisValue]=svmpredict(tempTest(:,1),tempTest(:,2:3),model(k,1));    
    acc(k,4)=k;
    
    %%%%%%%%%%%number of support vectors.
    svNumber(k,1)=length(model(k,1).SVs);%totalSV parameter is also OK.----but for free sopport 
    %vector���иı䣬Ҫ���lapha��Ϊ0��c֮��ĵ㣬ע�⣡����
    %%%%%%%%%55
    %k=k+1;
    %%%%%%%%%%%%firstly I 
    %����distance����֮ǰѧϰ����yn(w'*xn+b)������xinyidde�Ľ��ȷʵ����
    %����������̵���⣬���ң�������������ĺ�����ȣ�ѧϰsign֮��Ĵ���
    %%%%%%%%%%%%%%%%����epsilon n
    for n=1:model(k,1).totalSV%loop for the support vectors
        if abs((model(k,1).sv_coef(n,1)))==C(1,k)%��һ���Լ�д��k,1ϸ�ھ��������ע�⡣
            wz=0;
            for m=1:model(k,1).totalSV%for the sum each of m
                wz=wz+model(k,1).sv_coef(m,1)*exp(-100*norm(model(k,1).SVs(n,1:2)-model(k,1).SVs(m,1:2))^2);
            end
            s=1-sign(model(k,1).sv_coef(n,1))*(wz-model(k,1).rho);
            violation(n,k)=s;
        end
    end
    v(1,k)=sum(violation(:,k));
    end
%end

% w=model.SVs'*model.sv_coef;
% answer=sqrt(w'*w)
%%%%%%%%%%%%%%%%%unkonw code information for future improvement
% 	obj=[-2.380633,-23.144993,-178.198592,-1401.258805,-13027.302689]; %??18????????model??obj??
% for n=1:5
% norm_w(1,n)=sqrt(obj(1,n)+sum(abs(model(1,n).sv_coef)));
% end
% distance=1./norm_w;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%