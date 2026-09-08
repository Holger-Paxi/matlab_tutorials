function tab = trapezoidal_n_divisions_function(n, x_0, x_n, func)

    % new variables
    h = (x_n - x_0)/n; % delta_x
    x_inner = x_0+h:h:x_n-h;
    
    % true value of integral
    true_value = integral(func, x_0, x_n);
    
    % calculations
    inter = func(x_0);
    for x_i = x_inner
        inter = inter + 2.*func(x_i);
    end
    inter = inter + func(x_n);
    inter = (h./2).*inter;

    % relative error
    rel_error = abs((inter - true_value).*100./true_value);

    % results
    tab = table(n, h, x_0, x_n, true_value, inter, rel_error);

end