train1=sortrows(train_set,1);
train2=sortrows(train_set,2);
N=length(train_set);
theta1=-Inf;
theta2=-Inf;
for n=2:N
  theta1(n,1)=train1(n-1,1)+train1(n,1);
  theta2(n,1)=train2(n-1,2)+train2(n,1);
end
theta=[theta1;theta1;theta2;theta2];
s=[[ones(N,1),zeros(N,1)];
    [-1*ones(N,1),zeros(N,1)];
    [zeros(N,1),ones(N,1)];
    [zeros(N,1),-1*ones(N,1)];];

for n=1:4*N
  predict(n,:)=abs(sign(train_set(:,3)'-sign(s(n,1)*(train_set(:,1)'-theta(n,1)')+s(n,2)*(train_set(:,2)'-theta(n,1)'))));
end
t=1/N;
u=ones(1,N)*t;  
for T=1:300
    U(T,1)=sum(u);
    search=(predict*u')';
    [inc,pos(T,1)]=min(search);
    et=inc/sum(u);
    etm(T,1)=et;
    t(T,1)=sqrt((1-et)/et);
    mul=predict(pos(T,1),:)*t(T,1)+abs(predict(pos(T,1),:)-ones(1,N))/t(T,1);
    u=u.*mul;
end


   for T=1:300
     n=pos(T,1);
     pred(T,:)=sign(s(n,1)*(train_set(:,1)'-theta(n,1)')+s(n,2)*(train_set(:,2)'-theta(n,1)'));
   end
   
   Gpred=sign(log(t)'*pred);
   
   g1pretest=sign(s(pos(1,1),1)*(test_set(:,1)'-theta(pos(1,1),1)')+s(pos(1,1),2)*(test_set(:,2)'-theta(pos(1,1),1)'));
   
 for T=1:300
     n=pos(T,1);
     Gpredt(T,:)=sign(s(n,1)*(test_set(:,1)'-theta(n,1)')+s(n,2)*(test_set(:,2)'-theta(n,1)'));
   end
   
   Gpredtest=sign(log(t)'*Gpredt);
   