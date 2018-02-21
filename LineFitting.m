function [a,b] = LineFitting(X,Y)
% author:bingo
%date:2016-11-1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%  直线拟合函数  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 输入：X——输入点横坐标向量
%       Y——输入点纵坐标向量
% 输出：a——得到的直线函数的y=ax+b中的a
%       b——得到的直线函数的y=ax+b中的b
% 函数描述：根据输入参数中的X,Y向量，使用最小二乘法拟合出直线y=ax+b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=1;    %在其他程序中，m可以改变，表示拟合目标为m次函数
n=length(X);	
for i=1:(m+1)
    syms fai x;
    fai=x^(i-1);
    for j=1:n
        x=X(j);
        H(i,j)=eval(fai);
    end
end
A=Y*(H)'/(H*(H)');
syms x; 
f=0;
for i=1:(m+1)
    f=f+A(i)*x^(i-1);
end
% plot(X,Y,'*')
% hold on
% ezplot(f,[X(1),X(n)])
x1 = [0 10];
x = x1(1);
y1=eval(f);
x = x1(2);
y2 = eval(f);
a = (y2-y1)/(x1(2)-x1(1));
x = 0;
b = eval(f);
return