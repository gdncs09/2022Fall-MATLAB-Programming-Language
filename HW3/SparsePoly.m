%郭大寧109550184
classdef SparsePoly
    properties
        degree = 0;
        coeff = 0; 
    end
    methods
        function obj = SparsePoly(deg, coe) %constructor
            if nargin == 0
                obj.degree = 0;
                obj.coeff = 0;
            elseif nargin == 2 
                validateattributes(deg,{'numeric'},{'row','nonnegative','decreasing'}); %check degree
                if length(coe) > 1
                    validateattributes(coe,{'numeric'},{'row','nonzero'}); %check coefficient
                end
                if length(deg) ~= length(coe) %check degree and coefficient length
                    error("Length Error");
                end
                obj.degree = deg;
                obj.coeff = coe;
            else
                error('Input error!');
            end
        end

        function out = plus(a,b)   
            if ~isscalar(a) && ~isscalar(b) && ...
                    size(a,1) == size(b,1) && size(a,2) == size(b,2) % 2 SparsePoly non-scalar array
                out = a; %init
                for ii = 1:size(a,1) * size(a,2)
                    first = a(ii);
                    second = b(ii);
                    out(ii) = add(first,second); %methods private
                end
            elseif ~isscalar(a) && isscalar(b) % 1 SparsePoly non-scalar array + 1 scalar 
                out = a;
                for ii = 1:size(a,1) * size(a,2)
                    first = a(ii);
                    second = b;
                    out(ii) = add(first,second);
                end
            elseif isscalar(a) && ~isscalar(b) % 1 scalar + 1 SparsePoly non-scalar array
                out = b;
                for ii = 1:size(b,1) + size(b,2)
                    first = a;
                    second = b(ii);
                    out(ii) = add(first,second);
                end
                %{
            elseif isscalar(a) && isscalar(b) %scalar and scalar
                out = add(a,b);
                %}
            else
                error("Input Error");
            end
        end

        function out = minus(a,b)
            if ~isscalar(a) && ~isscalar(b) && ...
                    size(a,1) == size(b,1) && size(a,2) == size(b,2)
                out = a;
                for ii = 1:size(a,1) * size(a,2)
                    first = a(ii);
                    second = b(ii);
                    out(ii) = sub(first,second);
                end
            elseif ~isscalar(a) && isscalar(b)
                out = a;
                for ii = 1:size(a,1) * size(a,2)
                    first = a(ii);
                    second = b;
                    out(ii) = sub(first,second);
                end
            elseif isscalar(a) && ~isscalar(b)
                out = b;
                for ii = 1:size(b,1) * size(b,2)
                    first = a;
                    second = b(ii);
                    out(ii) = sub(first,second);
                end
                %{
            elseif isscalar(a) && isscalar(b)
                out = sub(a,b);
                %}
            else
                error("Input Error");
            end
        end
        
        function out = times(a,b)
            if ~isscalar(a) && ~isscalar(b) && ...
                    size(a,1) == size(b,1) && size(a,2) == size(b,2)
                out = a;
                for ii = 1:size(a,1) * size(a,2)
                    first = a(ii);
                    second = b(ii);
                    out(ii) = mul(first,second);
                end
            elseif ~isscalar(a) && isscalar(b)
                out = a;
                for ii = 1:size(a,1) * size(a,2)
                    first = a(ii);
                    second = b;
                    out(ii) = mul(first,second);
                end
            elseif isscalar(a) && ~isscalar(b)
                out = b;
                for ii = 1:size(b,1) * size(b,2)
                    first = a;
                    second = b(ii);
                    out(ii) = mul(first,second);
                end
                %{
            elseif isscalar(a) && isscalar(b)
                out = mul(a,b);
                %}
            else
                error("Input Error");
            end
        end
            
        function out = eval(a, x)
            validateattributes(x,{'numeric'},{'row'}); %check x
            if ~isscalar(a) %SparsePoly array
                out = cell(size(a)); %init
                for ii = 1:size(a,1) * size(a,2)
                    in = a(ii);
                    out{ii} = poly_eval(in,x); %methods private
                end
            else
                error("Input Error");
            end
        end
        
        function out = plot(a,x)
            validateattributes(x,{'numeric'},{'row'}); %check x
            if ~isscalar(a) %SparsePoly array
                out = eval(a,x);
                figure;
                hold on
                for ii = 1:size(out,1) * size(out,2)
                    y = out{ii}; %get y
                    plot(x,y);              
                end  
                hold off
            else
                error("Input Error");
            end
            %}  
        end

        function disp(a)
            pr = "";
            if size(a,1) == 1 && size(a,2) == 1
                for ii = 1:length(a.degree)
                    if a.coeff(ii) > 0
                        if ii~=1
                            pr = pr + "+";
                        end
                        pr = pr+num2str(a.coeff(ii));
                    elseif a.coeff(ii) < 0  
                        pr = pr+num2str(a.coeff(ii));
                    end
                    
                    if a.degree(ii) > 0 
                        pr = pr+"x";
                        if a.degree(ii) > 0
                            pr = pr + "^"+num2str(a.degree(ii));
                        end 
                    end
                end
                if pr == ""
                    pr = "0";
                end
                fprintf("%s\n",pr);
            else
                pr = pr + "SparsePoly array";
                fprintf("%s (size %dx%d)\n",pr,size(a,1),size(a,2));
            end
            
        end
   
    end
    
    methods (Access = private)
        function out = add(a, b)
            deg = [a.degree b.degree]; %all 2 poly degree
            deg = sort(unique(deg),'descend'); %unique degree
            %calculate coefficient
            coe = zeros(1,length(deg)); %init
            n = 1;
            for ii = 1:length(a.degree)
                while a.degree(ii) < deg(n) %find location
                    n = n+1;
                end
                coe(n) = coe(n) + a.coeff(ii); %calculate
            end
            n = 1;
            for ii = 1:length(b.degree)
                while b.degree(ii) < deg(n) %find location
                    n = n+1;
                end
                coe(n) = coe(n) + b.coeff(ii); %calculate  
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
             out = SparsePoly;
             out.degree = deg;
             out.coeff = coe;
        end

        function out = sub(a, b)
            deg = [a.degree b.degree]; %all 2 poly degree
            deg = sort(unique(deg),'descend'); %unique degree
            %calculate coefficient
            coe = zeros(1,length(deg)); %init
            n = 1;
            for ii = 1:length(a.degree)
                while a.degree(ii) < deg(n) %find location
                    n = n+1;
                end
                coe(n) = coe(n) + a.coeff(ii); %calculate
            end
            n = 1;
            for ii = 1:length(b.degree)
                while b.degree(ii) < deg(n) %find location
                    n = n+1;
                end
                coe(n) = coe(n) - b.coeff(ii); %calculate  
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
             out = SparsePoly;
             out.degree = deg;
             out.coeff = coe;
        end

        function out = mul(a,b)
            mul_deg = zeros(1,length(a.degree)*length(b.degree));
            mul_val = zeros(1,length(a.coeff)*length(b.coeff));
            n = 0; 
            for ii = 1:length(a.degree)
                for jj = 1:length(b.degree)
                    n = n + 1;
                    mul_deg(n) = a.degree(ii)+b.degree(jj); %calculate all degree 
                    mul_val(n) = a.coeff(ii)*b.coeff(jj); %calculate all coefficient
                end
            end
            [mul_deg,idx] = sort(mul_deg,'descend');%sort all degree
            mul_val = mul_val(idx); %sort all coefficient
            deg = sort(unique(mul_deg),'descend'); %unique degree
            coe = zeros(1,length(deg));
            n = 1;
            for ii = 1:length(mul_val)
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
            out = SparsePoly();
            out.degree = deg;
            out.coeff = coe;
        end

        function y = poly_eval(a, x)   
            y = zeros(1,length(x));
            for ii = 1:length(x)
                for jj = 1:length(a.degree)
                    y(ii) = y(ii) + a.coeff(jj)*x(ii)^a.degree(jj); %Find y with x(ii) value
                end
            end
        end
    end
end

