function [ deltaRotationVector ] = getRotationVectorFromGyro( gyroValues, ...
    deltaRotationVector, timeFactor )

    EPSILON = 0.000000001;
    normValues = zeros(4,2);

    omegaMagnitude = sqrt(gyroValues(1) * gyroValues(1) ...
        + gyroValues(2) * gyroValues(2) ...
        + gyroValues(3) * gyroValues(3));
    if (omegaMagnitude > EPSILON) 
        normValues(1) = gyroValues(1) / omegaMagnitude;
        normValues(2) = gyroValues(2) / omegaMagnitude;
        normValues(3) = gyroValues(3) / omegaMagnitude;
    end
    thetaOverTwo = omegaMagnitude * timeFactor;
    sinThetaOverTwo = sin(thetaOverTwo);
    cosThetaOverTwo = cos(thetaOverTwo);

    deltaRotationVector(1) = sinThetaOverTwo * normValues(1);
    deltaRotationVector(2) = sinThetaOverTwo * normValues(2);
    deltaRotationVector(3) = sinThetaOverTwo * normValues(3);
    deltaRotationVector(4) = cosThetaOverTwo;
end

