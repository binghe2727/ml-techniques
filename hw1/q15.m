%体会自己调试参数，设置对应的参数值过程，如何有效地进行调参，选择合适的参数，阅读
%对应的api实现对应的功能
clear all;
feature_train=load('features.train.txt');
N=length(feature_train);%the longest dimension
temp=feature_train;%set 建立temp预防自己修改原来的数据，以后有用
for n=1:N
    if(feature_train(n,1)~=0)
        temp(n,1)=-1;
    else
        temp(n,1)=+1;
    end
end
model=svmtrain(temp(:,1),temp(:,2:3),'-t 0 -c 0.01');
%model=svmtrain(temp(:,2:3),temp(:,1),'-t 0 -c 0.01');
w=model.SVs'*model.sv_coef;
% model=svmtrain(temp(:,1),temp(:,2:3),'autoscale',false,'boxconstraint', ... 
%                 0.01,'kernel_function','linear','showplot',true);%when use C， 我们就设置对应的soft margin
% y=zeros(length(model.SupportVectorIndices),1);%计算表示对应的sv_coeff矩阵来进一步求解分析。
% for n=1:length(model.SupportVectorIndices)
%     y(n,1)=temp(model.SupportVectorIndices(n,1),1);
% end
% sv_coef=[(model.Alpha).*y,(model.Alpha).*y];
% w=sum(sv_coef.*model.SupportVectors);% 答案与给出的的模长0.6不一致，注意体会改变，如何优化。---后续有
%对应的python之后，思考下，如何进行的调试


%z之前的SVM自己调用的是MATLAB自带的svm但是，在调用对应的matlab自带的svm但是，在安装完对应的libsvm之后，就可以进行扩展运用了方便更多。