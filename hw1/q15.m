%����Լ����Բ��������ö�Ӧ�Ĳ���ֵ���̣������Ч�ؽ��е��Σ�ѡ����ʵĲ������Ķ�
%��Ӧ��apiʵ�ֶ�Ӧ�Ĺ���
clear all;
feature_train=load('features.train.txt');
N=length(feature_train);%the longest dimension
temp=feature_train;%set ����tempԤ���Լ��޸�ԭ�������ݣ��Ժ�����
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
%                 0.01,'kernel_function','linear','showplot',true);%when use C�� ���Ǿ����ö�Ӧ��soft margin
% y=zeros(length(model.SupportVectorIndices),1);%�����ʾ��Ӧ��sv_coeff��������һ����������
% for n=1:length(model.SupportVectorIndices)
%     y(n,1)=temp(model.SupportVectorIndices(n,1),1);
% end
% sv_coef=[(model.Alpha).*y,(model.Alpha).*y];
% w=sum(sv_coef.*model.SupportVectors);% ��������ĵ�ģ��0.6��һ�£�ע�����ı䣬����Ż���---������
%��Ӧ��python֮��˼���£���ν��еĵ���


%z֮ǰ��SVM�Լ����õ���MATLAB�Դ���svm���ǣ��ڵ��ö�Ӧ��matlab�Դ���svm���ǣ��ڰ�װ���Ӧ��libsvm֮�󣬾Ϳ��Խ�����չ�����˷�����ࡣ