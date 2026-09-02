function complex_sum_series_function(option, N)
% no return output

    % inputs
    % option = "all";
    % N = 20;
    
    % calculations
    summation = 0;
    
    if option == "all"
        iter_vector = 1:N;
    elseif option == "odd"
        iter_vector = 1:2:N;
    elseif option == "even"
        iter_vector = 2:2:N;
    else
        fprintf("wrong input\n")
    end
    
    for k = iter_vector
        summation = summation + (1+k^3)/(4+k);
    end
    
    fprintf( ...
        "N = %d\t\tsum type ""%s""\t\tResult = %.2f\n", ...
        N, option, summation ...
    )

end

% run in th console:
% complex_sum_series_function("all", 20)