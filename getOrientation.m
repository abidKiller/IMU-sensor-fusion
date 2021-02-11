function [values] = getOrientation(R, values)

        if length(R) == 9
            values(1) = atan2(R(2), R(5));
            values(2) = asin(-R(8));
            values(3) = atan2(-R(7), R(9));
        else
            values(1) = atan2(R(2), R(6));
            values(2) = asin(-R(10));
            values(3) = atan2(-R(9), R(11));
        end
end
