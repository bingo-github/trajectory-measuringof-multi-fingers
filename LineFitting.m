function [a,b] = LineFitting(X,Y)
% author:bingo
%date:2016-11-1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%  ֱ����Ϻ���  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���룺X������������������
%       Y�������������������
% �����a�����õ���ֱ�ߺ�����y=ax+b�е�a
%       b�����õ���ֱ�ߺ�����y=ax+b�е�b
% ����������������������е�X,Y������ʹ����С���˷���ϳ�ֱ��y=ax+b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=1;    %�����������У�m���Ըı䣬��ʾ���Ŀ��Ϊm�κ���
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