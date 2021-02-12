function [angleChange]= getAngleChange( R, prevR )

    %rd1=0; rd4=0; rd6=0; rd7=0; rd8=0;
    ri0=0; ri1=0; ri2=0; ri3=0; ri4=0; ri5=0; ri6=0; ri7=0; ri8=0;
    pri0=0; pri1=0; pri2=0; pri3=0; pri4=0; pri5=0; pri6=0; pri7=0; pri8=0;

    if length(R) == 9
        ri0 = R(1);
        ri1 = R(2);
        ri2 = R(3);
        ri3 = R(4);
        ri4 = R(5);
        ri5 = R(6);
        ri6 = R(7);
        ri7 = R(8);
        ri8 = R(9);
    elseif length(R) == 16
        ri0 = R(1);
        ri1 = R(2);
        ri2 = R(3);
        ri3 = R(5);
        ri4 = R(6);
        ri5 = R(7);
        ri6 = R(9);
        ri7 = R(10);
        ri8 = R(11);
    end
    
    if length(prevR) == 9
        pri0 = prevR(1);
        pri1 = prevR(2);
        pri2 = prevR(3);
        pri3 = prevR(4);
        pri4 = prevR(5);
        pri5 = prevR(6);
        pri6 = prevR(7);
        pri7 = prevR(8);
        pri8 = prevR(9);
    elseif length(prevR) == 16
        pri0 = prevR(1);
        pri1 = prevR(2);
        pri2 = prevR(3);
        pri3 = prevR(5);
        pri4 = prevR(6);
        pri5 = prevR(7);
        pri6 = prevR(9);
        pri7 = prevR(10);
        pri8 = prevR(11);
    end
    
    % calculate the parts of the rotation difference matrix we need
    % rd[i][j] = pri[0][i] * ri[0][j] + pri[1][i] * ri[1][j] + pri[2][i] * ri[2][j];
    rd1 = pri0 * ri1 + pri3 * ri4 + pri6 * ri7; %rd[0][1]
    rd4 = pri1 * ri1 + pri4 * ri4 + pri7 * ri7; %rd[1][1]
    rd6 = pri2 * ri0 + pri5 * ri3 + pri8 * ri6; %rd[2][0]
    rd7 = pri2 * ri1 + pri5 * ri4 + pri8 * ri7; %rd[2][1]
    rd8 = pri2 * ri2 + pri5 * ri5 + pri8 * ri8; %rd[2][2]
    
    angleChange(1) = atan2(rd1, rd4);
    angleChange(2) = asin(-rd7);
    angleChange(3) = atan2(-rd6, rd8);
end

