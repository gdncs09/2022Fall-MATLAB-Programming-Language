classdef Vec3
    properties
        x = 0
        y = 0
        z = 0
        
    end
    methods
        function obj = Vec3(x, y, z)
            if nargin == 3 && isnumeric(x) && isnumeric(y) && isnumeric(z)
                obj.x = x;
                obj.y = y;
                obj.z = z;
            else
                error('Input error!');
            end
        end
        
        function v = norm(p)
            v = zeros(size(p.x,1),size(p.x, 2));
            for ii = 1:size(p.x, 1)+size(p.x, 2)
                v(ii) = sqrt(p.x(ii)*p.x(ii)+p.y(ii)*p.y(ii)+p.z(ii)*p.z(ii));
            end
        end
        function v = iszero(p)
            v = zeros(size(p.x,1),size(p.x, 2));
            for ii = 1:size(p.x, 1)+size(p.x, 2)
                if (p.x(ii)==0 && p.y(ii)==0 && p.z(ii)==0)
                    v(ii)=true;
                end
            end
        end
        function v = normalize(p)
            if (sum(iszero(p)) > 0)
                 error('Input error!');
            end
            v.x = p.x./norm(p);
            v.y = p.y./norm(p);
            v.z = p.z./norm(p);
        end
        function v = inner_prod(a, b)
            v = zeros(size(a.x,1),size(a.x, 2));
            for ii = 1:size(a.x, 1)+size(a.x, 2)
                v(ii) = a.x(ii)*b.x(ii)+a.y(ii)*b.y(ii)+a.z(ii)*b.z(ii);
            end
            
        end
        function v = cross_prod(a, b)
            v.x = zeros(size(a.x,1),size(a.x, 2));
            v.y = zeros(size(a.y,1),size(a.y, 2));
            v.z = zeros(size(a.z,1),size(a.z, 2));
            for ii = 1:size(a.x,1)+size(a.x,2)  
                v.x(ii) = (a.y(ii)*b.z(ii)-a.z(ii)*b.y(ii));
                v.y(ii) = (a.z(ii)*b.x(ii)-a.x(ii)*b.z(ii));
                v.z(ii) = (a.x(ii)*b.y(ii)-a.y(ii)*b.x(ii));
            end
        end
        function disp(p)
            a = [p.x(:)'; p.y(:)'; p.z(:)'];
            fprintf("(%d, %d, %d)\n",a);
        end
        function v = plus(a, b)
            %{
            if (isnumeric(a) == false || isnumeric(b) == false)
                error('Input error!');
            end
            if ((isscalar(a.x) == false || isscalar(a.y) == false || isscalar(a.z) == false) && (isscalar(b.x) == false || isscalar(b.y) == false || isscalar(b.z) == false))
                error('Input error!');
            end
            %}
            v.x = a.x+b.x;
            v.y = a.y+b.y;
            v.z = a.z+b.z;
        end
        function v = minus(a, b) 
            %{
            if (isnumeric(a) == false || isnumeric(b) == false)
                error('Input error!');
            end
            if ((isscalar(a.x) == false || isscalar(a.y) == false || isscalar(a.z) == false) && (isscalar(b.x) == false || isscalar(b.y) == false || isscalar(b.z) == false))
                error('Input error!');
            end
            %}
            v.x = a.x-b.x;
            v.y = a.y-b.y;
            v.z = a.z-b.z;
        end
        function v = eq(a, b)
            %{
            if (isnumeric(a) == false || isnumeric(b) == false)
                error('Input error!');
            end
            if ((isscalar(a.x) == false || isscalar(a.y) == false || isscalar(a.z) == false) && (isscalar(b.x) == false || isscalar(b.y) == false || isscalar(b.z) == false))
                error('Input error!');
            end
            %}
            v = zeros(size(a.x,1),size(a.x, 2));
            for ii = 1:size(a.x, 1)+size(a.x, 2)
                if (a.x(ii)==b.x(ii) && a.y(ii)==b.y(ii) && a.z(ii)==b.z(ii))
                    v(ii)=true;
                end
            end
            
        end
        function v = times(a, b)
            if (isscalar(a) == false && isscalar(b) == false)
                error('Input error!');
            end
            if (isnumeric(b))
                if (isscalar(a.x) == true && isscalar(a.y) == true && isscalar(a.z) == true)
                    v.x = a.x*b;
                    v.y = a.y*b;
                    v.z = a.z*b;
                else 
                    error('Input error!');
                end
            elseif (isnumeric(a))
                if (isscalar(b.x) == true && isscalar(b.y) == true && isscalar(b.z) == true)
                    v.x = b.x*a;
                    v.y = b.y*a;
                    v.z = b.z*a;
                else 
                    error('Input error!');
                end
            end
        end
    end
end