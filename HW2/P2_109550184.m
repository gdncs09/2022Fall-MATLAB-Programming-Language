%郭大寧109550184
function out = P2_109550184(op, in1, in2)
    %Check Operation
    expectedOps = ["add", "subtract", "multiply", "plot", "eval"];
    validOp = validatestring(op, expectedOps); 
    
    %Check first polynomial
    validateattributes(in1,{'numeric'},{'ncols',2}); 
    validateattributes(in1(:,1),{'numeric'},{'nonnegative','decreasing'});
    if size(in1,1) > 1
        validateattributes(in1(:,2),{'numeric'},{'nonzero'});
    end
    %check second input
    switch validOp 
        case {"add", "subtract", "multiply"}
            validateattributes(in2,{'numeric'},{'ncols',2});
            validateattributes(in2(:,1),{'numeric'},{'nonnegative','decreasing'});
            if size(in2,1) > 1
                validateattributes(in2(:,2),{'numeric'},{'nonzero'});
            end
        case {"plot", "eval"}
            validateattributes(in2,{'numeric'},{'row'});
    end

    %Run
    switch validOp
        case "add"
            out = poly_add(in1, in2);
        case "subtract"
            out = poly_subtract(in1, in2);
        case "multiply"
            out = poly_multiply(in1, in2);
        case "plot"
            out = poly_plot(in1,in2);
        case "eval"
            out = poly_eval(in1,in2);
    end
    if size(out,2) == 0
        out = [0 0];
    end
    %print final polynomial answer
    if validOp == "add" || validOp == "subtract" || validOp == "multiply" 
        pr = "h(x)=";
        for ii = 1:size(out,1)
            if out(ii,2) > 0 && ii ~= 1
                pr = pr+"+"+num2str(out(ii,2));
            elseif out(ii,2) < 0 || ii==1
                pr = pr+num2str(out(ii,2));
            end
            if out(ii,1) > 0 
                pr = pr+"x^"+num2str(out(ii,1));
            end
        end 
        disp(pr);
    end
end

%add
function poly_out = poly_add(poly1, poly2)
    deg = [poly1(:,1); poly2(:,1)]; %all 2 poly degree
    deg = sort(unique(deg),'descend'); %unique degree
    %calculate coefficient
    coe = zeros(length(deg),1); %init
    n = 1;
    for ii = 1:size(poly1,1)
        while poly1(ii,1) < deg(n) %find location
            n = n+1;
        end
        coe(n) = coe(n) + poly1(ii,2); %calculate
    end
    n = 1;
    for ii = 1:size(poly2,1)
        while poly2(ii,1) < deg(n) %find location
            n = n+1;
        end
        coe(n) = coe(n) + poly2(ii,2); %calculate
    end
    %check zero coefficient
    if length(coe) > 1 
        n = 1;
        while n <= length(coe)
            if coe(n) == 0
                deg(n) = []; %delete
                coe(n) = []; %delete
            else 
                n = n + 1;
            end
        end
    elseif length(coe) == 1
        if coe(1) == 0
            deg(1) = 0;
        end
    end
    %answer
    poly_out = [deg coe]; 
end

%subtract
function poly_out = poly_subtract(poly1, poly2)
    deg = [poly1(:,1); poly2(:,1)]; %all 2 poly degree
    deg = sort(unique(deg),'descend'); %unique degree
    %calculate coefficient
    coe = zeros(length(deg),1);
    n = 1;
    for ii = 1:size(poly1,1)
        while poly1(ii,1) < deg(n) %find location
            n = n+1;
        end
        coe(n) = coe(n) + poly1(ii,2); %calculate
    end
    n = 1;
    for ii = 1:size(poly2,1)
        while poly2(ii,1) < deg(n) %find location
            n = n+1;
        end
        coe(n) = coe(n) - poly2(ii,2); %calculate
    end
    %check zero coefficient
    if length(coe) > 1 
        n = 1;
        while n <= length(coe)
            if coe(n) == 0
                deg(n) = []; %delete
                coe(n) = []; %delete
            else 
                n = n + 1;
            end
        end
    elseif length(coe) == 1
        if coe(1) == 0
            deg(1) = 0;
        end
    end
    %answer
    poly_out = [deg coe];
end

%multiply
function poly_out = poly_multiply(poly1, poly2)
    mul_val = zeros(size(poly1,1)*size(poly2,1),1);
    mul_deg = zeros(size(poly1,1)*size(poly2,1),1);
    n = 0; 
    for ii = 1:size(poly1,1)
        for jj = 1:size(poly2,1)
            n = n + 1;
            mul_deg(n) = poly1(ii,1)+poly2(jj,1); %calculate all degree 
            mul_val(n) = poly1(ii,2)*poly2(jj,2); %calculate all coefficient
        end
    end
    [mul_deg,idx] = sort(mul_deg,'descend');%sort all degree
    mul_val = mul_val(idx); %sort all coefficient
    deg = sort(unique(mul_deg),'descend'); %unique degree
    coe = zeros(length(deg),1);
    n = 1;
    for ii = 1:size(mul_val)
        while mul_deg(ii) < deg(n) %find location
            n = n + 1; 
        end
        coe(n) = coe(n) + mul_val(ii); %calculate coefficient
    end
    
    %check zero coefficient
    if length(coe) > 1 
        n = 1;
        while n <= length(coe)
            if coe(n) == 0
                deg(n) = []; %delete
                coe(n) = []; %delete
            else 
                n = n + 1;
            end
        end
    elseif length(coe) == 1
        if coe(1) == 0
            deg(1) = 0;
        end
    end
    %answer
    poly_out = [deg coe];
end

%plot
function y = poly_plot(poly, x)
    x = sort(x);
    y = poly_eval(poly,x);
    figure;
    plot(x, y);
end

%eval
function y = poly_eval(poly, x)
    y = zeros(length(x),1);
    for ii = 1:length(x)
        for jj = 1:size(poly,1)
            y(ii) = y(ii) + poly(jj,2)*x(ii)^poly(jj,1); %Find y with x(ii) value
        end
    end
end