% -------------------------------------------------------------------
%  Generated by MATLAB on 20-Sep-2022 10:36:43
%  MATLAB version: 9.13.0.2049777 (R2022b)
% -------------------------------------------------------------------
                               
%1
fprintf('Q1\n');
v = [3 7 5 2];
fprintf('%d/%d+%d/%d=%d/%d\n',v(1),v(2),v(3),v(4),v(1)*v(4)+v(2)*v(3),v(2)*v(4));
clear v;
%2
fprintf('Q2\n');
a = 1:1000;
fprintf('%d\n',sum(1./a));
clear a;
%3
fprintf('Q3\n');
a = 1:100;
b=cumprod(a);
fprintf('%d\n',1+sum(1./b));
%4
fprintf('Q4\n');
n = 5;
a = ones(n);
a(2:n-1,2:n-1) = 0;
disp(a);
a = ones(n);
a(3:n-2,3:n-2) = 0;
disp(a);
clear a;
%5
fprintf('Q5\n');
n = 7;
a = eye(n);
v = (1:n);
a(a==1)=v;
a
clear a;
%6
fprintf('Q6\n');
nx = 4;
ny = 5;
x = 1:nx;
y = 1:ny;
x = repmat(x,ny,1);
y = repmat(y(:),1,nx);
x
y