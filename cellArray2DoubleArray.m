function [ output_args ] = cellArray2DoubleArray( input_args )
% This function converts a cell array into a double array



    tmp = strrep( input_args(:,1),'"','');

    output_args = zeros(length(tmp), 1);
    for i=1:length(tmp)
        t = tmp{i, 1}(tmp{i, 1} ~= '"') ;
        output_args(i) = str2double(t);
    end
end

