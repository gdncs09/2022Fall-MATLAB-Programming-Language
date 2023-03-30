fprintf('Q1\n');
n = 7;
A = zeros(n);
center = floor(n/2);
[X,Y] = meshgrid(-center: center);
D = sqrt(X.^2+Y.^2);
A(D<2.5) = 1
clear A;

fprintf('Q2\n');
n = 7;
v = 1;
disp(v);
for ii = 2:n
    v = [v 0]+[0 v];
    disp(v);
end
clear v;

fprintf('Q3\n');
n= 7;
v = [3 5 2 2 3 7 1];
v = sort(v);
res = v(1);
for ii = 2:n
    if v(ii) ~= v(ii-1)
        res(end+1) = v(ii);
    end
end
disp(res);
%clear v;
%clear res;