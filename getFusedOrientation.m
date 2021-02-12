function [ fusedOrientation ] = getFusedOrientation( orientation, gyroOrientation )

    FILTER_COEFFICIENT = 0.98;
    oneMinusCoeff = (1.0 - FILTER_COEFFICIENT);
    % azimuth
    if (gyroOrientation(1) < -0.5 * pi && orientation(1) > 0.0)
        fusedOrientation(1) = (FILTER_COEFFICIENT ...
                * (gyroOrientation(1) + 2.0 * pi) + oneMinusCoeff ...
                * orientation(1));
            
        if fusedOrientation(1) > pi
            fusedOrientation(1) = fusedOrientation(1) - 2.0 * pi;
        end
    
    elseif (orientation(1) < -0.5 * pi && gyroOrientation(1) > 0.0)
    
        fusedOrientation(1) = (FILTER_COEFFICIENT ...
                * gyroOrientation(1) + oneMinusCoeff ...
                * (orientation(1) + 2.0 * pi));
            
        if fusedOrientation(1) > pi
            fusedOrientation(1) = fusedOrientation(1) - 2.0 * pi;
        end
    else
    
        fusedOrientation(1) = FILTER_COEFFICIENT * gyroOrientation(1) ...
                + oneMinusCoeff * orientation(1);
    end
 
    % pitch
    if (gyroOrientation(2) < -0.5 * pi && orientation(2) > 0.0)
    
        fusedOrientation(2) = (FILTER_COEFFICIENT ...
                * (gyroOrientation(2) + 2.0 * pi) + oneMinusCoeff ...
                * orientation(2));
            
        if fusedOrientation(2) > pi
            fusedOrientation(2) = fusedOrientation(2) - 2.0 * pi;
        end      
    
    elseif (orientation(2) < -0.5 * pi && gyroOrientation(2) > 0.0)
    
        fusedOrientation(2) = (FILTER_COEFFICIENT ...
                * gyroOrientation(2) + oneMinusCoeff ...
                * (orientation(2) + 2.0 * pi));
        
        if fusedOrientation(2) > pi
            fusedOrientation(2) = fusedOrientation(2) - 2.0 * pi;
        end
    
    else
    
        fusedOrientation(2) = FILTER_COEFFICIENT * gyroOrientation(2) ...
                + oneMinusCoeff * orientation(2);
    end
 
    % roll
    if (gyroOrientation(3) < -0.5 * pi && orientation(3) > 0.0)
    
        fusedOrientation(3) = (FILTER_COEFFICIENT ...
                * (gyroOrientation(3) + 2.0 * pi) + oneMinusCoeff ...
                * orientation(3));
        if fusedOrientation(3) > pi
            fusedOrientation(3) = fusedOrientation(3) - 2.0 * pi;
        end
    
    elseif (orientation(3) < -0.5 * pi && gyroOrientation(3) > 0.0)
  
        fusedOrientation(3) = (FILTER_COEFFICIENT ...
                * gyroOrientation(3) + oneMinusCoeff ...
                * (orientation(3) + 2.0 * pi));
        if fusedOrientation(3) > pi
            fusedOrientation(3) = fusedOrientation(3) - 2.0 * pi;
        end
                
    else
        fusedOrientation(3) = FILTER_COEFFICIENT * gyroOrientation(3)...
                + oneMinusCoeff * orientation(3);
    end
end

