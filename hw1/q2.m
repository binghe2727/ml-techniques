clc;
x=[1,0,-1;
    0,1,-1;
    0,-1,-1;
    -1,0,1;
    0,2,1;
    0,-2,1;
    -2,0,1];
z1=x(:,2).^2-2*x(:,1)+3;
z2=x(:,1).^2-2*x(:,2)-3;
z=[z1,z2];
y1=x(1:3,3);
y2=x(4:7,3);
%plot3(z1(1:3,:),z2(1:3,:),y1,'+','red')
%plot3(z1(4:7,:),z2(4:7,:),y2,'+','blue')
%plot3(z1(1:3,:),z2(1:3,:),y1,'red+')
%plot3(z1(4:7,:),z2(4:7,:),y2,'blue+')%atttention 1: we cannot first use the eye seeing the line,to get the opitimal Using the svm solution qp programming
%plot3(z1,z2,x())
y=[y1;y2];
%using the qp quadratic programming for q ,p, a ,c
%for q
%for kernel function but in this solution, we should use the z1 and z2
q=zeros(7,7);
%clc q;
for n=1:7
    for m=1:7
      q(n,m)=y(n,1)*y(m,1)*z(n,:)*z(m,:)';
    end
end
q=q+eye(7,7)*0.00000001%imporve the eigenvalue of the q matrix attention: later testing whether it is useful
%for p
p=-1*ones(7,1);
A=[-eye(7,7);y';-y'];%why -eye different from the text book!!debugging experience colleciton
%when something different from what you have learnt, try to think it from
%different perspection to get the idea because in matlab the quadratic
%programming is smaller than not bigger than!!!attention to read the api or
%the funciton help document by doc xxx in fact in matlab there can be more
%constrains in the linear x to see the document for more details like the
%equaion formula in fact by reading the document, we can find it is not
%easy to use the options functions, we should try something different.
c=zeros(9,1);
alpha=quadprog(q,p,A,c);
w=[0,0];
for n=1:7
    w=w+alpha(n,1)*y(n,1)*z(n,:);
end
b=zeros(7,1);
%clc b;
for n=1:7
    if alpha(n,1)>0.1
        b(n,1)=y(n,1)-w*z(n,:)';   %Big question, in final answer, we will have a lot of b for final decisio???,
        %in fact remember after get the b,w we should also use the
        %sign(w'x+b)for the justment.
    end
end 

%then use the b and w get the function sign(w'z+b) to get the final result
%for  soluion
