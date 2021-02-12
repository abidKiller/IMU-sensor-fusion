function [orientation]=fuseSensors(accelerometer,magnetometer,gyroscope,timestamp )

    MILLISECONDS_TO_SECONDS = 1/1000;

    gyroMatrix(1)=1.0;gyroMatrix(2)=0.0;gyroMatrix(3)=0.0;
    gyroMatrix(4)=0.0;gyroMatrix(5)=1.0;gyroMatrix(6)=0.0;
    gyroMatrix(7)=0.0; gyroMatrix(8)=0.0;gyroMatrix(9)= 1.0;
    
    initState = 0;
    numsamples=size(accelerometer,1);
    orientation= zeros(numsamples-1,3);
  
    ALPHA = 0.8; 
    gravity(1,:) = accelerometer(1,:);
    gravity(2:numsamples,:)=accelerometer(2:numsamples,:)*ALPHA ...
        +accelerometer(1:numsamples-1,:)*(1-ALPHA);
   
    rotationMatrix=getRotationMatrix(gravity(1,:),magnetometer(1,:));
    
    if (rotationMatrix) 
        accMagOrientation=getOrientation(rotationMatrix);
        orientation(1,:)=accMagOrientation;
    end
    
    %% Compute orientation
    for i=2:numsamples
        rotationMatrix = getRotationMatrix(gravity(i,:), magnetometer(i,:));
        if (rotationMatrix) 
            accMagOrientation=getOrientation(rotationMatrix);
        end
        if initState == 0
            initMatrix=getRotationMatrixFromOrientation(accMagOrientation);
            gyroMatrix =matrixMultiplication(gyroMatrix, initMatrix);
            initState =1;
        end
        
        dT =(timestamp(i,1)-timestamp(i-1,1))*MILLISECONDS_TO_SECONDS;
        [gyroOrientation]=getGyroOrientation(gyroMatrix,dT,gyroscope(i,:));
        [fusedOrientation]=getFusedOrientation(accMagOrientation,gyroOrientation );
        % Refine gyroscope drift
        gyroMatrix=getRotationMatrixFromOrientation(fusedOrientation);
        orientation(i,:)= fusedOrientation;
    end
end

