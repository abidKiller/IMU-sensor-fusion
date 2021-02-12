function [ Q ] = getQuaternionFromVector( rv )
    if (length(rv) == 4) 
        Q(1) = rv(4);
    else 
        Q(1) = 1 - rv(1)*rv(1) - rv(2)*rv(2) - rv(3)*rv(3);
        if Q(1) > 0
            Q(1) = sqrt(Q(1));
        else
            Q(1) = 0;
        end
    end
    Q(2) = rv(1);
    Q(3) = rv(2);
    Q(4) = rv(3);
end

