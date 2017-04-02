clc;
x=[ 1,0,-1;
    0,1,-1;
    0,-1,-1;
    -1,0,1;
    0,2,1;
    0,-2,1;
    -2,0,1];
%z1=x(:,2).^2-2*x(:,1)+3;
%z2=x(:,1).^2-2*x(:,2)-3;
%z=[z1,z2];
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
       
      q(n,m)=y(n,1)*y(m,1)*kernel(x(n,1:2),x(m,1:2));     %matlab中，注意对应的写函数，可以用先标注(这样就可以展开对应的参数值代入
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

temp=0;
for n=1:7
    if alpha(n,1)>0.01
        for m=1:7
            temp=temp+alpha(n,1)*y(n,1)*kernel(x(n,1:2),x(m,1:2));
        end
        b=y(n,1)-temp;
    end
end
a=sum(alpha);
	%方便化简
alpha=alpha*27;
b=b*27;

%then, we ge the alpha with 2,3,4,5,6 not zeros,
%then, we can use the support vector来计算对应的 kernel系数。并且附加上最后的，我想完成一个
%带有x参数的程序化简公式，但是，在编程里面，并不能进行对应这样的实现，这个非常重要
%注意体会对应的运用化简分析，很重要。体会matlab数值计算，JAVA也类似，必须在处理的时候，代入对应的数值，进行对应的展开计算。最后还是
%要赋值对应得数值，才可以更好地进行进一步的计算，但是，我们可以计算对应的alphaN和yN对应的乘积，来优化求解分析。