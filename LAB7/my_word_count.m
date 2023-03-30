function A = my_word_count(fn, sort_mode)
fid = fopen(fn, 'rt');
s = textscan(fid, '%s', 'delimiter', '., ');
fclose(fid);

list = lower(s{1});
list = string(list);
A.word = unique(list);
for ii=1:length(A.word)
    A.count(ii) = sum(strcmp(A.word(ii), list));
    A.len(ii) = strlength(A.word(ii));
end

switch sort_mode
    case 'word+'
        A.field = [A.word];
        mode = 'ascend';
    case 'word-'
        A.field = [A.word];
        mode = 'descend';
    case 'len+'
        A.field = [A.len];
        mode = 'ascend';
    case 'len-'
        A.field = [A.len];
        mode = 'descend';
    case 'count+'
        A.field = [A.count];
        mode = 'ascend';
    case 'count-'
        A.field = [A.count];
        mode = 'descend';
end

[A.field, idx] = sort(A.field, mode);
 A.word = A.word(idx);
 A.len = A.len(idx);
 A.count = A.count(idx);
output = [A.word'; A.len; A.count];
fprintf('%-12s %-3s %-3s\n',output);
 
