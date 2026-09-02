function simple_sum_series_function(N)
% the function does not a return variable

    % calculations
    summation = 0;
    
    fprintf("Iteration #\tSum\n");
    fprintf("-----------\t---\n");
    
    for k = 1:N
        summation = summation + k;
        fprintf("%d\t\t%d\n", k, summation);
    end

end

% run in the console:
% simple_sum_series_function(20)