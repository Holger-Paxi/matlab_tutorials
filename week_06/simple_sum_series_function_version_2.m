function tab = simple_sum_series_function_version_2(N)
% return output "tab"

    % calculations
    summation = 0;
    
    iter_vector = 1:N;
    sum_vector = zeros(1, N); % matrix of zero values (row, col)
    
    % fprintf("Iteration #\tSum\n");
    % fprintf("-----------\t---\n");
    
    for k = iter_vector
        summation = summation + k;
        sum_vector(k) = summation;
    end
    
    tab = table( ...
        iter_vector', sum_vector', ...
        'VariableNames', ["Iteration #" "Sum"] ...
        );
    
    % disp(tab)

end

% run in the console:
% simple_sum_series_function_version_2(20)
% table = simple_sum_series_function_version_2(20)
