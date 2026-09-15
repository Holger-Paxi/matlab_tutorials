function tab = composite_simpson_function(dx, x_a, x_b, func)
    %% 
    % true value
    
    true_value = integral(func, x_a, x_b);
    %% 
    % number of points
    
    n = (x_b - x_a)/dx + 1; % should be odd for simpson method
    n = ceil(n);
    % forcing n to be a odd number to be compared to simpson's
    if mod(n,2) == 0
        n = n + 1;
    end
    %% 
    % number of sub-intervals must be even
    
    n_sub = n - 1; % even number
    h = (x_b - x_a)/n_sub;
    %% 
    % slicing points to get inner points by excluding x_a and x_b
    
    x_inner = linspace(x_a, x_b, n);
    x_inner = x_inner(2: end-1);
    %% 
    % calculation of integral
    
    integ = func(x_a);
    for x_i = 1:length(x_inner)
        if mod(x_i,2) == 1 % odd
            integ = integ + 4.*func(x_inner(x_i));
        elseif mod(x_i,2) == 0 % even
            integ = integ + 2.*func(x_inner(x_i));
        end
    end
    integ = integ + func(x_b);
    integ = (h./3).*integ;
    %% 
    % relative error
    
    rel_error = abs((integ - true_value).*100./true_value);
    %% 
    % results in a table
    
    tab = table(...
        x_a, x_b, n, h, dx, true_value, integ, rel_error ...
    );
end