function [v, r, c] = max2d(A,k)
    validateattributes(A,{'numeric'},{'nonempty'});
    v = max(A(:));
    if nargout == 2
        [v, r] = max(A(:));
    elseif nargout == 3
        [v, n] = max(A(:));
        [r, c] = ind2sub(size(A), n);
    end
    
    if nargin == 2
        validateattributes(k,{'numeric'},{'scalar','>=',1,'<=',numel(A)});
        v = sort(A(:),'descend');
        v = v(1:k);
        if nargout == 2
             [v, r] = sort(A(:),'descend');
             v = v(1:k);
             r = r(1:k);
        elseif nargout == 3
             [v, n] = sort(A(:),'descend');
             v = v(1:k);
             n = n(1:k);
             [r, c] = ind2sub(size(A), n);
        end
    end
    
   