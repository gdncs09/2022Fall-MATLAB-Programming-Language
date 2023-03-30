function [word, count] = my_word_count(fn)
    fid =  fopen(fn,'rt');
    s = textscan(fid, '%s' ,'delimiter', '., ');
    fclose(fid);
    A = s{1};
    A = lower(A);
    word = unique(A);
    count = zeros(length(word),1);
    for ii=1:length(word)
        check = strcmp(word{ii},A);
        count(ii) = sum(check);
    end
    [count,idx] = sort(count,'descend');
    word = word(idx);
    
    if nargout == 0
        for ii=1:length(word)
            fprintf('%-12s %d\n',word{ii},count(ii));
        end
        
    end 
    
    
    
    
    