n=100; [x,y]=meshgrid(-n:2:n,-n:2:n); % the grid points
z1=sin((x-.002*x.*x)/n*5).^2+1;
z2=sin((x+2*y)/n*2).^2+.5;
t1=80; w1=t1*t1./((x-20).^2+(y-40).^2+t1*t1);
z=z1.*z2.*w1*1000+rand(size(z1))*.1; % values of the grid points

above = [false(1,101); z(2:end,:)>z(1:end-1,:)];
below = [z(1:end-1,:)>z(2:end,:); false(1,101)];
left = [false(101,1) z(:,2:end)>z(:,1:end-1)];
right = [z(:,1:end-1)>z(:,2:end) false(101,1)];

left_above = [false(1,101); false(100,1) z(2:end,2:end)>z(1:end-1,1:end-1)];
left_below = [false(100,1) z(1:end-1,2:end)>z(2:end,1:end-1); false(1,101)];
right_above = [false(1,101); z(2:end,1:end-1)>z(1:end-1,2:end) false(100,1)];
right_below = [z(1:end-1,1:end-1)>z(2:end,2:end) false(100,1); false(1,101)];

A=left&right&above&below&left_above&right_above&left_below&right_below;

lc = -n:2:n;
figure(1);

subplot(1,2,1);
contourf(x,y,z)

hold on
for yy=1:101
    for xx=1:101
        if A(yy,xx)==1
            text(lc(xx)-5,lc(yy)-5,num2str(z(yy,xx),'%.0f'));
            plot(lc(xx),lc(yy),'^','MarkerSize',3,'MarkerEdgeColor',[0,0,0],'MarkerFaceColor',[0,0,0]); 
        end    
    end
end
hold off

subplot(1,2,2);
surf(x,y,z)
hold on
for yy=1:101
    for xx=1:101
        if A(yy,xx)==1
            text(lc(xx)-5,lc(yy)-5,z(yy,xx)+200,num2str(z(yy,xx),'%.0f'),'color','b','fontweight','bold');
            plot3(lc(xx),lc(yy),z(yy,xx),'^','MarkerSize',5,'MarkerEdgeColor','b','MarkerFaceColor','b'); 
        end    
    end
end

