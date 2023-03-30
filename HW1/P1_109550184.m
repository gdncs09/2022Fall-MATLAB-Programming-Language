%郭大寧109550184
%input value
x = 3:100;
y = sin(.05*x + .002*x.^2) .* (1 - x.*x/20000);

%run
len = x(1)-1; %calculate x start location

%local max
left = [false(1,1) y(2:end)>=y(1:end-1)]; %y(x)>=y(x-1)
right = [y(1:end-1)>=y(2:end) false(1,1)]; %y(x)>=y(x+1)
A = left&right; 
lcmax = find(A); %find local maximum
fprintf("Local maximums:\n")
lcmaxans=[lcmax+len; y(lcmax)]; %local maximum (x,y)
fprintf("( %d, %.2f)\n",lcmaxans); %print local maximum answer

%local min
left = [false(1,1) y(2:end)<=y(1:end-1)]; %y(x)<=y(x-1)
right = [y(1:end-1)<=y(2:end) false(1,1)]; %y(x)<=y(x+1)
B = left&right;
lcmin = find(B); %find local minimum
fprintf("Local minimums:\n");
lcminans=[lcmin+len; y(lcmin)]; %local minimum (x,y)
fprintf("( %d, %.2f)\n",lcminans); %print local minimum answer

%monotonically inc dec
if lcmax(1) > lcmin(1) %check start point
    inc = [lcmin+len;lcmax+len]; %mononically increasing
    dec = [x(1) lcmax+len;lcmin+len x(end)]; %mononically decreasing
elseif lcmin(1) > lcmax(1) %check start point
    inc = [x(1) lcmin+len;lcmax+len x(end)]; %mononically increasing
    dec = [lcmax+len;lcmin+len]; %mononically decreasing
end
%mononically increasing
fprintf("Monotonically increasing seqments:\n");
fprintf("%d\t - \t%d\n",inc);
%mononically decreasing
fprintf("Monotonically decreasing seqments:\n");
fprintf("%d\t - \t%d\n",dec);

%figture
figure(1);
plot(x, y,'.-','MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor','b');
hold on
plot(lcmax+len,y(lcmax),'square','MarkerSize',10,'MarkerEdgeColor','r'); %local max
plot(lcmin+len,y(lcmin),'diamond','MarkerSize',10,'MarkerEdgeColor','m'); %local min