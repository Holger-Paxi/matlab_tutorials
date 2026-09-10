function tab = simpson_n_divisions_function_v2(n, x_0, x_n, func)

    % new variables
    h = (x_n - x_0)/n; % delta_x
    x_inner = x_0+h:h:x_n-h;
    ind_vect = 1:length(x_inner);

    % true value of integral
    true_value = integral(func, x_0, x_n);
    
    % calculations
    inter = func(x_0);
    for ind = ind_vect
        if mod(ind,2) == 1 % odd
            inter = inter + 4.*func(x_inner(ind));
        elseif mod(ind,2) == 0 % even
            inter = inter + 2.*func(x_inner(ind));
        end
    end
    inter = inter + func(x_n);
    inter = (h./3).*inter;

    % relative error
    rel_error = abs((inter - true_value).*100./true_value);
    
    % results
    tab = table(n, h, x_0, x_n, true_value, inter, rel_error);

end