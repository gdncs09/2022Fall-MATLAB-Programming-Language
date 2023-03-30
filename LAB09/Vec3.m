classdef Vec3
    properties
        x = 0
        y = 0
        z = 0
        
    end
    methods
        function obj = Vec3(x, y, z)
            if nargin == 0
                obj.x = 0;
                obj.y = 0;
                obj.z = 0;
            elseif nargin == 1 && isscalar(x)
                obj.x = x;
            elseif nargin == 2 && isscalar(x) && isscalar(y)
                obj.x = x;
                obj.y = y;
            elseif nargin == 3 && isscalar(x) && isscalar(y) && isscalar(z)
                obj.x = x;
                obj.y = y;
                obj.z = z;
            else
                error('Input error!');
            end
        end
        
        function v = norm(p)
            v = sqrt(p.x*p.x + p.y*p.y +p.z*p.z);
        end
        function v = iszero(p)
            if (p.x == 0)
                v(1) = true;
            else 
                v(1) = false;
            end
            if (p.y == 0)
                v(2) = true;
            else 
                v(2) = false;
            end
            if (p.z == 0)
                v(3) = true;
            else 
                v(3) = false;
            end
        end
        function v = normalize(p)
            if (sum(iszero(p)) > 0)
                 error('Input error!');
            end
            
        end
        function v = inner_prod(a, b)
            v = a.x*b.x+a.y*b.y+a.z*b.z;
        end
        function disp(p)
            a = [];
            for i=1:size(p.x,1)*size(p.x,2)
                a = [a p.x(i) p.y(i) p.z(i)];
            end
            fprintf("(%d, %d, %d)\n",a);
        end
        function v = plus(a, b)
            if (isnumeric(a) == false || isnumeric(b) == false)
                error('Input error!');
            end
            if ((isscalar(a.x) == false || isscalar(a.y) == false || isscalar(a.z) == false) && (isscalar(b.x) == false || isscalar(b.y) == false || isscalar(b.z) == false))
                error('Input error!');
            end
            v.x = a.x+b.x;
            v.y = a.y+b.y;
            v.z = a.z+b.z;
        end
        function v = minus(a, b) 
            if (isnumeric(a) == false || isnumeric(b) == false)
                error('Input error!');
            end
            if ((isscalar(a.x) == false || isscalar(a.y) == false || isscalar(a.z) == false) && (isscalar(b.x) == false || isscalar(b.y) == false || isscalar(b.z) == false))
                error('Input error!');
            end
            v.x = a.x-b.x;
            v.y = a.y-b.y;
            v.z = a.z-b.z;
        end
        function v = eq(a, b)
            if (isnumeric(a) == false || isnumeric(b) == false)
                error('Input error!');
            end
            if ((isscalar(a.x) == false || isscalar(a.y) == false || isscalar(a.z) == false) && (isscalar(b.x) == false || isscalar(b.y) == false || isscalar(b.z) == false))
                error('Input error!');
            end
            if (a.x == b.x)
                v(1) = true;
            else
                v(1) = false;
            end
            if (a.y == b.y)
                v(2) = true;
            else
                v(2) = false;
            end
            if (a.z == b.z)
                v(3) = true;
            else
                v(3) = false;
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