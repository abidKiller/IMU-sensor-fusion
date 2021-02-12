function [ R, I ] = getRotationMatrix(gravity, geomagnetic )

     Ax = gravity(1);
     Ay = gravity(2);
     Az = gravity(3);
      Ex = geomagnetic(1);
      Ey = geomagnetic(2);
      Ez = geomagnetic(3);
     Hx = Ey*Az - Ez*Ay;
     Hy = Ez*Ax - Ex*Az;
     Hz = Ex*Ay - Ey*Ax;
      normH = sqrt(Hx*Hx + Hy*Hy + Hz*Hz);
    if (normH < 0.1) 
  
        disp('Device is close to free fall');
        return ;
    end

    invH = 1.0 / normH;
    Hx = Hx * invH;
    Hy = Hy * invH;
    Hz = Hz * invH;
    invA = 1.0 / sqrt(Ax*Ax + Ay*Ay + Az*Az);
    Ax = Ax * invA;
    Ay = Ay * invA;
    Az = Az * invA;
    Mx = Ay*Hz - Az*Hy;
    My = Az*Hx - Ax*Hz;
    Mz = Ax*Hy - Ay*Hx;
    
    R = zeros(9, 1);
    
    if (length(R) == 9) 
        R(1) = Hx;     R(2) = Hy;     R(3) = Hz;
        R(4) = Mx;     R(5) = My;     R(6) = Mz;
        R(7) = Ax;     R(8) = Ay;     R(9) = Az;
    elseif (length(R) == 16)
      
        R(0)  = Hx;    R(1)  = Hy;    R(2)  = Hz;   R(3)  = 0;
        R(4)  = Mx;    R(5)  = My;    R(6)  = Mz;   R(7)  = 0;
        R(8)  = Ax;    R(9)  = Ay;    R(10) = Az;   R(11) = 0;
        R(12) = 0;     R(13) = 0;     R(14) = 0;    R(15) = 1;
    end
    
    
    I = zeros(9, 1);
    

      invE = 1.0 / sqrt(Ex*Ex + Ey*Ey + Ez*Ez);
      c = (Ex*Mx + Ey*My + Ez*Mz) * invE;
      s = (Ex*Ax + Ey*Ay + Ez*Az) * invE;
    if (length(I) == 9) 
        I(1) = 1;     I(2) = 0;     I(3) = 0;
        I(4) = 0;     I(5) = c;     I(6) = s;
        I(7) = 0;     I(8) =-s;     I(9) = c;
    elseif (length(I) == 16) 
      
        I(0) = 1;     I(1) = 0;     I(2) = 0;
        I(4) = 0;     I(5) = c;     I(6) = s;
        I(8) = 0;     I(9) =-s;     I(10)= c;
        I(3) = 0; I(7) = 0; I(11) = 0; I(12) = 0; I(13) = 0; I(14) = 0;
        I(15) = 1;
    end
end

