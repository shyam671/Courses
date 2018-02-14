function L  = detect_last_o( Lo )
len = 0;
for i = size(Lo,2):-1:1
    if(Lo(i))~=0
        len = i;
        break;
    end

end
L = Lo(1:len);

