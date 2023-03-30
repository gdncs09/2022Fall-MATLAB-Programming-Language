xi = -10:2:10;
yi = -.03*xi.^2 + .1*xi + 2 + 1*(rand(1,length(xi))-.5);
figure(1)

for r = 1:3
    
    A = zeros(length(xi),r+1);

    for row = 1:length(xi)    
        for col = 1:r+1
            A(row,col) = xi(row).^(col-1);
        end
    end
    ai = A\yi';
    y = A*ai;
    subplot(1,3,r); plot(xi,y');
    hold on
    plot(xi',yi','o');
    plot([xi;xi],[yi;y'],'-');
    title('Polynomial deg=',r);
    rmse = sqrt(mean((yi-y').^2));
    text(4,-1,sprintf('%.3f',rmse));
end
