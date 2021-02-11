function [] = test(filename)    
    filename = 'sensordata.csv';
    % Timestamp
    [ttimestamp] = csvimport( filename, 'columns', 3,'noHeader', true );
    timestamp = cellArray2DoubleArray(ttimestamp);

    % Accelerometer
    [tAccX, tAccY, tAccZ] = csvimport( filename, 'columns', [4, 5, 6],'noHeader', true );

    AccX = cellArray2DoubleArray(tAccX);
    AccY = cellArray2DoubleArray(tAccY);
    AccZ = cellArray2DoubleArray(tAccZ);
    Acc = [AccX, AccY, AccZ];

    % Magnetometer
    [tMagnX, tMagnY, tMagnZ] = csvimport( filename, 'columns', [10, 11, 12],'noHeader', true );

    MagnX = cellArray2DoubleArray(tMagnX);
    MagnY = cellArray2DoubleArray(tMagnY);
    MagnZ = cellArray2DoubleArray(tMagnZ);
    Magn = [MagnX, MagnY, MagnZ];

    % Gyroscope
    [tGyroX, tGyroY, tGyroZ] = csvimport( filename, 'columns', [16, 17, 18],'noHeader', true ); 

    GyroX = cellArray2DoubleArray(tGyroX);
    GyroY = cellArray2DoubleArray(tGyroY);
    GyroZ = cellArray2DoubleArray(tGyroZ);
    Gyro = [GyroX, GyroY, GyroZ];

    % Sensor fusion
    [ fusedOrientation ] = fuseSensors( Acc, Magn, Gyro, timestamp );

   
    numorientation = size(fusedOrientation, 1);
    time = (1:numorientation)';

    
    
   
    k = 1;
    myaxes = axes('xlim', [-k,k], 'ylim', [-k,k], 'zlim', [-k,k]);
    view(3);
    grid on;
    axis (myaxes);
    hold on

    [rollaxis, pitchaxis, yawaxis] = cylinder([0.05 0.05]);%axis cylinders are defined
    

    h(1) = surface(rollaxis, pitchaxis, yawaxis, 'FaceColor', 'r');
    h(2) = surface(rollaxis, -yawaxis, -pitchaxis, 'FaceColor', 'b');
    h(3) = surface(yawaxis, rollaxis, pitchaxis, 'FaceColor', 'g');
    p1 = [-.5 -.5 .1];
p2 = [.5 -.5 .1];
p3 = [.5 .5 .1];
p4 = [-.5 .5 .1]; 

    p5 = [-.5 -.5 -.1];
p6 = [.5 -.5 -.1];
p7= [.5 .5 -.1];
p8 = [-.5 .5 -.1]; 

x = [p1(1) p2(1) p3(1) p4(1)];
y = [p1(2) p2(2) p3(2) p4(2)];
z = [p1(3) p2(3) p3(3) p4(3)];

x1 = [p5(1) p6(1) p7(1) p8(1)];
y1 = [p5(2) p6(2) p7(2) p8(2)];
z1 = [p5(3) p6(3) p7(3) p8(3)];


    
    
    


    h(4)=fill3(x, y, z, 1);
    h(5)=fill3(x1, y1, z1, 3);
    
    legend('YAW AXIS', 'PITCH AXIS', 'ROLL AXIS','AutoUpdate','off')

    combinedobject = hgtransform('parent', myaxes);
    set(h, 'parent', combinedobject);
    drawnow;

    [row,col]= size(fusedOrientation);
    for i = 1: row
           disp(i);

    
           yaw = fusedOrientation(i,1);
           pitch = fusedOrientation(i,2);
           roll =  fusedOrientation (i,3);         

           rotation1 = makehgtform('xrotate', (180/pi)*(roll), 'yrotate', (180/pi)*(pitch), 'zrotate', (180/pi)*(yaw));
           set(combinedobject, 'matrix', rotation1);
           drawnow update;
           pause(.1)

%                rotation2 = makehgtform('yrotate', (pi/180)*(pitch));
%                set(combinedobject, 'matrix', rotation2);
%                drawnow;
% 
%                rotation3 = makehgtform('zrotate', (pi/180)*(yaw));
%                set(combinedobject, 'matrix', rotation3);
%                drawnow;
               %refresh(f);
          
    
    end
    
    
end


